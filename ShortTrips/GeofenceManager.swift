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
  private var lastCheckedLocation: CLLocation?
  private var insideSfoBufferedExit = false
  var checkThreshold: Double {
    return insideSfoBufferedExit ? 30 : 300
  }
  private var lastKnownGeofences: [SfoGeofence]?
  
  static let sharedInstance = GeofenceManager()
  
  func start() {
    if locationObserver == nil {
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
      
      GeofenceArbiter.requestGeofencesForLocation(location.coordinate) { geofences in
          
          if let geofences = geofences {
            self.process(geofences)
            postNotification(SfoNotification.Geofence.foundInside, value: geofences)
          }
          
          self.lastCheckedLocation = location
      }
    }
  }

  private func process(geofences: [SfoGeofence]) {
    
    if geofences.contains(.TaxiExitBuffered) {
      InsideBufferedExit.sharedInstance.fire()
      insideSfoBufferedExit = true
    } else {
      OutsideBufferedExit.sharedInstance.fire()
      insideSfoBufferedExit = false
    }
    
    if geofences.contains(.SfoTaxiDomesticExit)
      && !geofences.contains(.TaxiWaitingZone) {
      InsideTaxiLoopExit.sharedInstance.fire()
    }
    
    if geofences.contains(.TaxiWaitingZone) {
      InsideTaxiWaitingZone.sharedInstance.fire()
    } else {
      OutsideTaxiWaitZone.sharedInstance.fire()
    }
    
    lastKnownGeofences = geofences
  }
  
  func stillInsideTaxiWaitZone() -> Bool {
    if let lastKnownGeofences = lastKnownGeofences {
      return lastKnownGeofences.contains(.TaxiWaitingZone)
    } else {
      return false
    }
  }
  
  func stillInsideDomesticExit() -> Bool {
    if let lastKnownGeofences = lastKnownGeofences {
      return lastKnownGeofences.contains(.SfoTaxiDomesticExit)
    } else {
      return false
    }
  }
  
  func stillInsideSfoBufferedExit() -> Bool {
    return insideSfoBufferedExit
  }
}
