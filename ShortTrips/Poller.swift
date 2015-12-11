//
//  Poller.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/16/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

typealias Action = Void -> Void

class Poller: NSObject {
  
  private static let standardTimeout: NSTimeInterval = 60 * 5 // 5 min
  private let interval: NSTimeInterval = 10
  private var action: Action
  private var creationDate: NSDate!
  private var timeout: NSTimeInterval
  private var timer: NSTimer!
  private var failure: Action?

  init(timeout: NSTimeInterval = standardTimeout,
    failure: Action? = nil,
    action: Action) {

    self.timeout = timeout
    self.action = action
    self.creationDate = NSDate()
    self.failure = failure

    super.init()

    timer = NSTimer.scheduledTimerWithTimeInterval(interval,
      target: self,
      selector: "check",
      userInfo: nil,
      repeats: true)
    
    action()
  }
  
  func stop() {
    self.timer?.invalidate()
    self.timer = nil
  }
  
  func check() {
    if let failure = failure
      where creationDate.timeIntervalSinceNow < -timeout {
        
      stop()
      failure()
        
    } else {
      action()
    }
  }
}
