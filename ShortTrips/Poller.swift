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
  
  private var action: Action
  private var creationDate: NSDate!
  private var timeout: NSTimeInterval
  private var timer: NSTimer!
  
  init(timeout: NSTimeInterval, action: Action) {
    self.timeout = timeout
    self.action = action
    self.creationDate = NSDate()
    
    super.init()
    
    timer = NSTimer.scheduledTimerWithTimeInterval(5,
      target: self,
      selector: "check",
      userInfo: nil,
      repeats: true)
  }
  
  func stop() {
    self.timer?.invalidate()
    self.timer = nil
  }
  
  func check() {
    if creationDate.timeIntervalSinceNow < -timeout {
      stop()
      Failure.sharedInstance.fire()
      
    } else {
      action()
    }
  }
}
