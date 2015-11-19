//
//  GeofenceDebugger.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

extension DebugVC {
  
  func setupGeofenceObservers() {
    
    exitingTerminalsObserver = NotificationObserver(notification: SfoNotification.Geofence.exitingTerminals) { _, _ in
      self.debugView().printDebugLine("exiting terminals event!", type: .Positive)
    }
    
    foundInsideGeofencesObserver = NotificationObserver(notification: SfoNotification.Geofence.foundInside) { geofences, _ in
      self.debugView().updateGeofenceList(geofences)
      for geofence in geofences {
        self.debugView().printDebugLine("in geofence: \(geofence.name)", type: .Positive)
      }
    }
    
    insideSfoObserver = NotificationObserver(notification: SfoNotification.Geofence.insideSfo) { _, _ in
      self.debugView().printDebugLine("inside SFO event!", type: .Positive)
    }
    
    outsideShortTripObserver = NotificationObserver(notification: SfoNotification.Geofence.outsideShortTrip) { _, _ in
      self.debugView().printDebugLine("Trip went outside Short Trip geofence", type: .Negative)
    }
  }
}
