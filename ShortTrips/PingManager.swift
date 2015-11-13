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

class PingManager: NSObject {

  var lastSuccessfulPingDate: NSDate?
  let updateFrequency = NSTimeInterval(30)
  private var invalidPings: Int = 0
  private let maxInvalidPings: Int = 3
  
  private var timer: NSTimer?

  var pingObserver: NotificationObserver<(ping: ShortTrips.Ping, geofenceStatusBool: Bool?), AnyObject>?
  
  static let sharedInstance = PingManager()

  override private init() {}

  func start() {
    
    if let _ = timer {} else {
      timer = NSTimer.scheduledTimerWithTimeInterval(updateFrequency,
        target: self,
        selector: "processLastKnownLocation",
        userInfo: nil,
        repeats: true)
    }
    
    if let _ = pingObserver {} else {
      self.pingObserver = NotificationObserver(notification: SfoNotification.Ping.sent, handler: { info, _ in
        let geofenceStatusBool = info.geofenceStatusBool
        let ping = info.ping
      
        if let geofenceStatusBool = geofenceStatusBool {
          self.lastSuccessfulPingDate = NSDate()
          postNotification(SfoNotification.Ping.successful, value: ping)
          
          if geofenceStatusBool {
            postNotification(SfoNotification.Ping.valid, value: ping)
            self.invalidPings = 0 // must be consecutive
            
          } else {
            postNotification(SfoNotification.Ping.invalid, value: ping)
            self.invalidPings++
            if self.invalidPings >= self.maxInvalidPings {
              OutsideShortTripGeofence.sharedInstance.fire()
              self.invalidPings = 0 // reset invalid pings
            }
          }
        } else {
          postNotification(SfoNotification.Ping.unsuccessful, value: ping)
        }
      })
    }
  }

  func stop() {
    timer?.invalidate()
    timer = nil
    pingObserver = nil
  }

  private func processLastKnownLocation() {
    if let location = LocationManager.sharedInstance.getLastKnownLocation() {
      if let tripId = TripManager.sharedInstance.getTripId() {
        let ping = Ping(location: location)
        postNotification(SfoNotification.Ping.attempting, value: ping)
        ApiClient.ping(tripId, ping: ping) { geofenceStatusBool in
          postNotification(SfoNotification.Ping.sent, value: (ping: ping, geofenceStatusBool: geofenceStatusBool))
        }
      }
    }
  }
}
