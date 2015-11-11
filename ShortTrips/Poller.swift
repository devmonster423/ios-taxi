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
  private var failure: Action
  
  init(timeout: NSTimeInterval, action: Action, failure: Action?){

    self.timeout = timeout
    self.action = action
    self.creationDate = NSDate()
    
    if let failure = failure {
      self.failure = failure
    }else{
      self.failure = { _ in
        Failure.sharedInstance.fire()
      }
    }

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
      failure()
      
    } else {
      action()
    }
  }
}
