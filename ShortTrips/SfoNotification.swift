//
//  Notification.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/15/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import CoreLocation
import JSQNotificationObserverKit

struct SfoNotification {
  static let attemptingPing = Notification<Ping, AnyObject>(name: "AttemptingPing")
  static let foundInsideGeofences = Notification<[Geofence], AnyObject>(name: "FoundInsideGeofences")
  static let locationManagerStarted = Notification<Any?, AnyObject>(name: "LocationManagerStarted")
  static let locationRead = Notification<CLLocation, AnyObject>(name: "LocationRead")
  static let successfulPing = Notification<Ping, AnyObject>(name: "SuccessfulPing")
}
