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
    foundInsideGeofencesObserver = NotificationObserver(notification: SfoNotification.Geofence.foundInside, handler: { geofences, _ in
      self.debugView().updateGeofenceList(geofences)
      for geofence in geofences {
        self.debugView().printDebugLine("in geofence: \(geofence.name)", type: .Positive)
      }
    })
    
    insideSfoObserver = NotificationObserver(notification: SfoNotification.Geofence.insideSfo, handler: { (value, sender) -> Void in
      self.debugView().printDebugLine("inside SFO event!", type: .Positive)
    })
    
    outsideSfoObserver = NotificationObserver(notification: SfoNotification.Geofence.outsideSfo, handler: { (value, sender) -> Void in
      self.debugView().printDebugLine("outside SFO event!", type: .Positive)
    })
  }
}
