//
//  PingKiller.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/8/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation

class PingKiller: NSObject {
  static let sharedInstance = PingKiller()
  
  private var killPings = false
  private var timer: NSTimer!
  
  func turnOffPingsForAWhile() {
    killPings = true
    
    timer = NSTimer.scheduledTimerWithTimeInterval(2 * 60,
      target: self,
      selector: "turnPingsBackOn",
      userInfo: nil,
      repeats: true)
  }
  
  func turnPingsBackOn() {
    killPings = false
  }
  
  func shouldKillPings() -> Bool {
    return killPings
  }
}
