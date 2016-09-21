//
//  GeofenceManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import CoreLocation

class GeofenceManager {
  
  var locationObserver: NotificationObserver<CLLocation, AnyObject>?
  fileprivate var lastCheckedLocation: CLLocation?
  fileprivate var insideSfoBufferedExit = false
  var checkThreshold: Double {
    return insideSfoBufferedExit ? 30 : 300
  }
  fileprivate var lastKnownGeofences: [SfoGeofence]?
  
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
  
  func process(_ location: CLLocation) {
    
    if lastCheckedLocation == nil
      || location.distance(from: lastCheckedLocation!) > checkThreshold {
      
      GeofenceArbiter.requestGeofencesForLocation(location.coordinate) { geofences in
          
          if let geofences = geofences {
            self.process(geofences)
            postNotification(SfoNotification.Geofence.foundInside, value: geofences)
          }
          
          self.lastCheckedLocation = location
      }
    }
  }

  fileprivate func process(_ geofences: [SfoGeofence]) {
    
    if geofences.contains(.taxiExitBuffered) {
      InsideBufferedExit.sharedInstance.fire()
      insideSfoBufferedExit = true
    } else {
      OutsideBufferedExit.sharedInstance.fire()
      insideSfoBufferedExit = false
    }
    
    if geofences.contains(.sfoTaxiDomesticExit)
      && !geofences.contains(.taxiWaitingZone) {
      InsideTaxiLoopExit.sharedInstance.fire()
    }
    
    if geofences.contains(.taxiWaitingZone) {
      InsideTaxiWaitingZone.sharedInstance.fire()
    } else {
      OutsideTaxiWaitZone.sharedInstance.fire()
    }
    
    lastKnownGeofences = geofences
  }
  
  func stillInsideTaxiWaitZone() -> Bool {
    if let lastKnownGeofences = lastKnownGeofences {
      return lastKnownGeofences.contains(.taxiWaitingZone)
    } else {
      return false
    }
  }
  
  func stillInDomesticExitNotInHoldingLot() -> Bool {
    if let lastKnownGeofences = lastKnownGeofences {
      return lastKnownGeofences.contains(.sfoTaxiDomesticExit) && !lastKnownGeofences.contains(.taxiWaitingZone)
    } else {
      return false
    }
  }
  
  func stillInsideSfoBufferedExit() -> Bool {
    return insideSfoBufferedExit
  }
}
