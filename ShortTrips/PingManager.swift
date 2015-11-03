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
  private var invalidPings: Int = 0
  private let maxInvalidPings: Int = 3

  var locationObserver: NotificationObserver<CLLocation, AnyObject>?

  static let sharedInstance = PingManager()

  private init() {}

  func start() {
    if let _ = locationObserver {} else {
      self.locationObserver = NotificationObserver(notification: SfoNotification.Location.read, handler: { location, _ in
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
      postNotification(SfoNotification.Ping.attempting, value: ping)
      ApiClient.ping(tripId, ping: ping) { geofenceStatus in
        if let geofenceStatus = geofenceStatus {
          self.lastSuccessfulPingDate = NSDate()
          postNotification(SfoNotification.Ping.successful, value: ping)
          if geofenceStatus {
            postNotification(SfoNotification.Ping.valid, value: ping)
          } else {
            postNotification(SfoNotification.Ping.invalid, value: ping)
            self.invalidPings++
            if self.invalidPings >= self.maxInvalidPings {
              OutsideShortTripGeofence.sharedInstance.fire()
            }
          }
        } else {
          postNotification(SfoNotification.Ping.unsuccessful, value: ping)
        }
      }
    }
  }
}
