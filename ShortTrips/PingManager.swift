//
//  PingManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import CoreLocation

class PingManager: NSObject {

  private let updateFrequency = TimeInterval(30)
  private var invalidPings: Int = 0
  private let maxInvalidPings: Int = 3
  private var missedPings = [Ping]()
  
  private var timer: Timer?

  static let sharedInstance = PingManager()

  func start() {
    
    if timer == nil {
      timer = Timer.scheduledTimer(timeInterval: updateFrequency,
        target: self,
        selector: #selector(PingManager.sendPings),
        userInfo: nil,
        repeats: true)
    }
    
    let nc = NotificationCenter.default
    
    nc.addObserver(forName: .pingCreated, object: nil, queue: nil) { note in
      
      let ping = note.userInfo![InfoKey.ping] as! Ping
      
      if ping.geofenceStatus.toBool() {
        nc.post(name: .pingValid, object: nil, userInfo: [InfoKey.ping: ping])
        self.invalidPings = 0 // must be consecutive
        
      } else {
        nc.post(name: .pingInvalid, object: nil, userInfo: [InfoKey.ping: ping])
        self.invalidPings += 1
        if self.invalidPings >= self.maxInvalidPings {
          OutsideShortTripGeofence.sharedInstance.fire()
          self.invalidPings = 0 // reset invalid pings
        }
      }
    }
  }

  func stop() {
    timer?.invalidate()
    timer = nil
    NotificationCenter.default.removeObserver(self)
  }

  func sendPings() {
    makeAndSendNewPing()
    sendOldPings(TripManager.sharedInstance.getTripId())
  }
  
  func makeAndSendNewPing() {

    guard let location = LocationManager.sharedInstance.getLastKnownLocation(),
      let tripId = TripManager.sharedInstance.getTripId(),
      let sessionId = DriverManager.sharedInstance.getCurrentDriver()?.sessionId,
      let vehicleId = DriverManager.sharedInstance.getCurrentVehicle()?.vehicleId else
    {
      fatalError("invalid ping info")
    }
    
    let medallion = DriverManager.sharedInstance.getCurrentVehicle()?.medallion

    let ping = Ping(location: location,
      tripId: tripId,
      vehicleId: vehicleId,
      sessionId: sessionId,
      medallion: medallion)
    
    NotificationCenter.default.post(name: .pingCreated, object: nil, userInfo: [InfoKey.ping: ping])
    ApiClient.ping(tripId, ping: ping) { success in
      
      if !success {
        self.appendStrip(ping)
      }
    }
  }
  
  func sendOldPings(_ tripId: Int?) {
    if let pingBatch = getPingBatch(),
      let tripId = tripId {
        
        let sentPings = pingBatch.pings
        self.missedPings.removeAll()
        
        ApiClient.pings(tripId, pings: pingBatch) { success in
          if !success {
            self.missedPings.append(contentsOf: sentPings!)
          }
        }
    }
  }
  
  func appendStrip(_ ping: Ping) {
    var ping = ping
    
    ping.medallion = nil
    ping.sessionId = nil
    ping.tripId = nil
    ping.vehicleId = nil
    self.missedPings.append(ping)
  }
  
  func getPingBatch() -> PingBatch? {
    
    if let sessionId = DriverManager.sharedInstance.getCurrentDriver()?.sessionId
      , missedPings.count > 0 {
      
      return PingBatch(sessionId: sessionId, pings: missedPings)
        
    } else {
      return nil
    }
  }
}
