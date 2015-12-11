//
//  GeofenceManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import CoreLocation
import JSQNotificationObserverKit

class GeofenceManager {
  
  var locationObserver: NotificationObserver<CLLocation, AnyObject>?
  var lastCheckedLocation: CLLocation?
  
  let checkThreshold: Double = 50 // meters
  static let sharedInstance = GeofenceManager()
  
  func start() {
    if let _ = locationObserver {} else {
      self.locationObserver = NotificationObserver(notification: SfoNotification.Location.read) { location, _ in
        self.process(location)
      }
    }
  }

  func stop() {
    locationObserver = nil
  }
  
  func process(location: CLLocation) {
    
    if lastCheckedLocation == nil
      || location.distanceFromLocation(lastCheckedLocation!) > checkThreshold {
      
      ApiClient.requestGeofencesForLocation(location.coordinate.latitude,
        longitude: location.coordinate.longitude,
        buffer: GeofenceArbiter.buffer) { geofences in
          
          if let geofences = geofences {
            self.process(geofences.flatMap { geofence -> SfoGeofence? in return geofence.geofence })
            postNotification(SfoNotification.Geofence.foundInside, value: geofences)
          }
          
          self.lastCheckedLocation = location
      }
    }
  }

  private func process(geofences: [SfoGeofence]) {
    
    if geofences.contains(.Sfo) {
      InsideSfo.sharedInstance.fire()
    } else {
      OutsideSfo.sharedInstance.fire()
    }
    
    if geofences.contains(.TaxiWaitingZone) {
      InsideTaxiWaitingZone.sharedInstance.fire()
    } else {
      OutsideTaxiWaitingZone.sharedInstance.fire()
    }
    
    if geofences.contains(.SfoTaxiDomesticExit)
      && !geofences.contains(.TaxiWaitingZone) {
      InsideTaxiLoopExit.sharedInstance.fire()
    }
    
    if geofences.contains(.SfoTerminalExit)
      && !geofences.contains(.SfoInternationalExit)
      && !geofences.contains(.SfoTaxiDomesticExit) {
      ExitingTerminals.sharedInstance.fire()
        
    } else if geofences.contains(.Sfo) {
      InsideSfoNotExitingTerminals.sharedInstance.fire()
    }
    
    if !geofences.contains(.SfoTaxiDomesticExit) {
      NotInDomesticExit.sharedInstance.fire()
    }
  }
}
