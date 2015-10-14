//
//  LocationManagerStarted.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

struct LocationManagerStarted {
  static func fire() {
    postNotification(notification(), value: nil)
  }

  static func notification() -> Notification<Any?, AnyObject> {
    return Notification<Any?, AnyObject>(name: "LocationManagerStarted")
  }
}
