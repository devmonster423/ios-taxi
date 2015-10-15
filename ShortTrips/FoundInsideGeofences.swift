//
//  FoundInsideGeofence.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

struct FoundInsideGeofences {
  static func fire(geofence: [Geofence]) {
    postNotification(notification(), value: geofence)
  }

  static func notification() -> Notification<[Geofence], AnyObject> {
    return Notification<[Geofence], AnyObject>(name: "FoundInsideGeofences")
  }
}
