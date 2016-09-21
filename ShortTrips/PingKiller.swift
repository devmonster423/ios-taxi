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
  
  fileprivate var killPings = false
  fileprivate var timer: Timer!
  
  func turnOffPingsForAWhile() {
    killPings = true
    
    timer = Timer.scheduledTimer(timeInterval: 2 * 60,
      target: self,
      selector: #selector(PingKiller.turnPingsBackOn),
      userInfo: nil,
      repeats: false)
  }
  
  func turnPingsBackOn() {
    killPings = false
  }
  
  func shouldKillPings() -> Bool {
    return killPings
  }
}
