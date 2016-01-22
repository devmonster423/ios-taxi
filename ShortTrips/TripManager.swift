//
//  TripManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/2/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

class TripManager: NSObject {
  
  static let sharedInstance = TripManager()
  
  private var startTime: NSDate?
  private var tripId: Int?
  private var tripTimer: NSTimer?
  private static let timerInterval: NSTimeInterval = 5.0
  private static let tripLengthLimit: NSTimeInterval = 2 * 60 * 60 // 2 hours
  private var mostRecentTripValid: Bool?
  
  func getTripId() -> Int? {
    return tripId
  }
  
  func reset() {
    PingManager.sharedInstance.stop()
    tripTimer?.invalidate()
    tripId = nil
    startTime = nil
  }

  func setStartTime(time: NSDate) {
    self.startTime = time
  }
  
  func getElapsedTime() -> NSTimeInterval? {
    if let interval = startTime?.timeIntervalSinceNow {
      return -interval
    } else {
      return nil
    }
  }
  
  func checkLength() {
    if getElapsedTime() > TripManager.tripLengthLimit {
      TimeExpired.sharedInstance.fire()
    }
  }
  
  func start(tripId: Int) {
    self.tripId = tripId
    
    if startTime == nil {
      startTime = NSDate()
    }

    PingManager.sharedInstance.start()
    
    if let tripTimer = tripTimer {
      tripTimer.invalidate()
    }
    
    tripTimer = NSTimer.scheduledTimerWithTimeInterval(TripManager.timerInterval,
      target: self,
      selector: "checkLength",
      userInfo: nil,
      repeats: true)
    
    TripStarted.sharedInstance.fire(tripId)
  }
  
  func stop(valid valid: Bool = false) {
    mostRecentTripValid = valid
    reset()
  }
  
  func mostRecentTripWasValid() -> Bool {
    if let mostRecentTripValid = mostRecentTripValid {
      return mostRecentTripValid
    } else {
      return false
    }
  }
}
