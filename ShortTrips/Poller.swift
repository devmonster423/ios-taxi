//
//  Poller.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/16/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

typealias Action = (Void) -> Void

class Poller: NSObject {
  
  fileprivate let interval: TimeInterval = 10
  fileprivate var action: Action
  fileprivate var timer: Timer!

  init(action: @escaping Action) {

    self.action = action

    super.init()

    timer = Timer.scheduledTimer(timeInterval: interval,
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
