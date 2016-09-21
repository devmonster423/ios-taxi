//
//  TripManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/2/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class TripManager: NSObject {
  
  static let sharedInstance = TripManager()
  
  fileprivate var startTime: Date?
  fileprivate var tripId: Int?
  fileprivate var tripTimer: Timer?
  fileprivate var rightAfterValidShort = false
  fileprivate static let timerInterval: TimeInterval = 5.0
  fileprivate static let tripLengthLimit: TimeInterval = 2 * 60 * 60 // 2 hours
  
  func getTripId() -> Int? {
    return tripId
  }
  
  func getRightAfterValidShort() -> Bool {
    return rightAfterValidShort
  }
  
  func reset(_ validShort: Bool) {
    PingManager.sharedInstance.stop()
    tripTimer?.invalidate()
    tripId = nil
    startTime = nil
    rightAfterValidShort = validShort
  }

  func setStartTime(_ time: Date) {
    self.startTime = time
  }
  
  func getStartTime() -> Date? {
    return startTime
  }
  
  func getElapsedTime() -> TimeInterval? {
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
  
  func start(_ tripId: Int) {
    self.tripId = tripId
    
    if startTime == nil {
      startTime = Date()
    }

    PingManager.sharedInstance.start()
    
    if let tripTimer = tripTimer {
      tripTimer.invalidate()
    }
    
    tripTimer = Timer.scheduledTimer(timeInterval: TripManager.timerInterval,
      target: self,
      selector: #selector(TripManager.checkLength),
      userInfo: nil,
      repeats: true)
    
    TripStarted.sharedInstance.fire(tripId)
  }
}
