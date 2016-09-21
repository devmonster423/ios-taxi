//
//  GeofenceDebugger.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

extension DebugVC {
  
  func setupGeofenceObservers() {
    
    sfoObservers.foundInsideGeofencesObserver = NotificationObserver(notification: SfoNotification.Geofence.foundInside) { geofences, _ in
      self.debugView().updateGeofenceList(geofences)
    }
    
    sfoObservers.outsideShortTripObserver = NotificationObserver(notification: SfoNotification.Geofence.outsideShortTrip) { _, _ in
      self.debugView().printDebugLine("Outside short trip geofence.", type: .Negative)
    }
  }
}
