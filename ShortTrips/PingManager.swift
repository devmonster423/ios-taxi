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

  var pingObserver: NotificationObserver<(ping: ShortTrips.Ping, geofenceStatus: FoundGeofenceStatus?), AnyObject>?
  
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
      self.pingObserver = NotificationObserver(notification: SfoNotification.Ping.created, handler: { info, _ in
        
        let geofenceStatus = info.geofenceStatus
        let ping = info.ping
      
        if let geofenceStatus = geofenceStatus {
          self.lastSuccessfulPingDate = NSDate()
          postNotification(SfoNotification.Ping.successful, value: ping)
          
          if geofenceStatus.status.toBool() {
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

  func processLastKnownLocation() {
    if let location = LocationManager.sharedInstance.getLastKnownLocation(),
      let tripId = TripManager.sharedInstance.getTripId(),
      let sessionId = DriverManager.sharedInstance.getCurrentDriver()?.sessionId,
      let medallion = DriverManager.sharedInstance.getCurrentVehicle()?.medallion {
        
        let ping = Ping(location: location, tripId: tripId, sessionId: sessionId, medallion: medallion)
        postNotification(SfoNotification.Ping.attempting, value: ping)
        ApiClient.ping(tripId, ping: ping) { geofenceStatus in
          postNotification(SfoNotification.Ping.created, value: (ping: ping, geofenceStatus: geofenceStatus))
        }
    }
  }
}
