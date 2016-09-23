//
//  LatestAviReadAtTaxiLoop.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class LatestAviAtTaxiLoop {
  let eventNames = ["LatestAviAtTaxiLoop"]
  static let sharedInstance = LatestAviAtTaxiLoop()
  
  fileprivate var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForTaxiLoopAvi.sharedInstance.getState()],
      to: Ready.sharedInstance.getState())]
  }
}

extension LatestAviAtTaxiLoop: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension LatestAviAtTaxiLoop: Observable {
  func eventIsFiring(_ info: Any?) {
    if let antenna = info as? Antenna {
      NotificationCenter.default.post(name: .aviRead, object: nil, userInfo: [InfoKey.antenna: antenna])
    }
  }
}
