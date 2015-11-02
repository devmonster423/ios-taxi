//
//  TripManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/2/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

class TripManager {
  
  static let sharedInstance = TripManager()
  
  private var startTime: NSDate?
  private var tripId: Int?
  private var tripTimer: NSTimer?
  private static let timerInterval: NSTimeInterval = 5.0
  private static let tripLengthLimit: NSTimeInterval = 2 * 60 * 60 // 2 hours
  
  private init() {}
  
  func getTripId() -> Int? {
    return tripId
  }
  
  func setTripId(tripId: Int) {
    self.tripId = tripId
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
  
  private func checkLength() {
    if getElapsedTime() > TripManager.tripLengthLimit {
      TimeExpired.sharedInstance.fire()
    }
  }
  
  func startTimer() {
    if let tripTimer = tripTimer {
      tripTimer.invalidate()
    }
    
    tripTimer = NSTimer.scheduledTimerWithTimeInterval(TripManager.timerInterval,
      target: self,
      selector: "checkLength",
      userInfo: nil,
      repeats: true)
  }
  
  func stopTimer() {
    tripTimer?.invalidate()
  }
}