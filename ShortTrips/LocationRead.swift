//
//  LocationReadDebugEvent.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import CoreLocation
import JSQNotificationObserverKit

struct LocationRead {
  static func fire(location: CLLocation) {
    postNotification(notification(), value: location)
  }

  static func notification() -> Notification<CLLocation, AnyObject> {
    return Notification<CLLocation, AnyObject>(name: "LocationRead")
  }
}
