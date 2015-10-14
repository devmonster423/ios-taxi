//
//  SuccessfulPing.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

struct SuccessfulPing {
  static func fire(ping: Ping) {
    postNotification(notification(), value: ping)
  }

  static func notification() -> Notification<Ping, AnyObject> {
    return Notification<Ping, AnyObject>(name: "SuccessfulPing")
  }
}
