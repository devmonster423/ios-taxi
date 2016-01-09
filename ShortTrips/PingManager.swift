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
  private var missedPings = [Ping]()
  
  private var timer: NSTimer?

  var pingObserver: NotificationObserver<(ping: Ping, geofenceStatus: FoundGeofenceStatus), AnyObject>?
  
  static let sharedInstance = PingManager()

  func start() {
    
    if timer == nil {
      timer = NSTimer.scheduledTimerWithTimeInterval(updateFrequency,
        target: self,
        selector: "sendPings",
        userInfo: nil,
        repeats: true)
    }
    
    if pingObserver == nil {
      self.pingObserver = NotificationObserver(notification: SfoNotification.Ping.created, handler: { info, _ in
        
        let ping = info.ping
        var geofenceStatus = info.geofenceStatus.status
        
        if geofenceStatus == .NotVerified {
          geofenceStatus = ping.geofenceStatus
        }
      
        if let geofenceStatus = geofenceStatus {
          self.lastSuccessfulPingDate = NSDate()
          postNotification(SfoNotification.Ping.successful, value: ping)
          
          if geofenceStatus.toBool() {
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

  func sendPings() {
    sendNewPing()
    sendOldPings()
  }
  
  func sendNewPing() {

    if let location = LocationManager.sharedInstance.getLastKnownLocation(),
      let tripId = TripManager.sharedInstance.getTripId(),
      let sessionId = DriverManager.sharedInstance.getCurrentDriver()?.sessionId,
      let vehicleId = DriverManager.sharedInstance.getCurrentVehicle()?.vehicleId
      {
    
        let medallion = DriverManager.sharedInstance.getCurrentVehicle()?.medallion
    
        let ping = Ping(location: location,
          tripId: tripId,
          vehicleId: vehicleId,
          sessionId: sessionId,
          medallion: medallion)
        
        postNotification(SfoNotification.Ping.attempting, value: ping)
        ApiClient.ping(tripId, ping: ping) { geofenceStatus in
          
          if let geofenceStatus = geofenceStatus {
            postNotification(SfoNotification.Ping.created, value: (ping: ping, geofenceStatus: geofenceStatus))
          } else {
            self.appendStrip(ping)
          }
        }
    }
  }
  
  func sendOldPings() {
    if let pingBatch = getPingBatch(),
      let tripId = TripManager.sharedInstance.getTripId() {
        
        let sentPings = pingBatch.pings
        self.missedPings.removeAll()
        
        ApiClient.pings(tripId, pings: pingBatch) { success in
          if !success {
            self.missedPings.appendContentsOf(sentPings)
          }
        }
    }
  }
  
  func appendStrip(var ping: Ping) {
    ping.medallion = nil
    ping.sessionId = nil
    ping.tripId = nil
    ping.vehicleId = nil
    self.missedPings.append(ping)
  }
  
  func getPingBatch() -> PingBatch? {
    
    if let sessionId = DriverManager.sharedInstance.getCurrentDriver()?.sessionId
      where missedPings.count > 0 {
      
      return PingBatch(sessionId: sessionId, pings: missedPings)
        
    } else {
      return nil
    }
  }
}
