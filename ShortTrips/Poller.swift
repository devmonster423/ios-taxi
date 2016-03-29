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
  
  private let interval: NSTimeInterval = 10
  private var action: Action
  private var timer: NSTimer!

  init(action: Action) {

    self.action = action

    super.init()

    timer = NSTimer.scheduledTimerWithTimeInterval(interval,
      target: self,
      selector: #selector(Poller.check),
      userInfo: nil,
      repeats: true)
    
    action()
  }
  
  func stop() {
    self.timer?.invalidate()
    self.timer = nil
  }
  
  func check() {
    action()
  }
}
