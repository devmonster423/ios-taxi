//
//  PingManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import CoreLocation
import JSQNotificationObserverKit

class PingManager {

  var lastSuccessfulPingDate: NSDate?
  let updateFrequency = NSTimeInterval(60)

  var locationObserver: NotificationObserver<CLLocation, AnyObject>?

  static let sharedInstance = PingManager()

  private init() {}

  func start() {
    if let _ = locationObserver {} else {
      self.locationObserver = NotificationObserver(notification: LocationRead.notification(), handler: { location, _ in
        self.process(location)
      })
    }
  }

  func stop() {
    locationObserver = nil
  }

  private func process(location: CLLocation) {
    var pingDate = NSDate(timeIntervalSince1970: 0)
    if let lastSuccessfulPingDate = lastSuccessfulPingDate {
      pingDate = lastSuccessfulPingDate
    }

    if pingDate.timeIntervalSinceNow < -updateFrequency,
      let tripId = TripManager.sharedInstance.getTripId() {

        let ping = Ping(location: location)
        AttemptingPing.fire(ping)

        ApiClient.ping(tripId, ping: ping, response: { geofenceStatus in

          if let _ = geofenceStatus {
            self.lastSuccessfulPingDate = NSDate()
            SuccessfulPing.fire(ping)
          }
        })
    }
  }
}
