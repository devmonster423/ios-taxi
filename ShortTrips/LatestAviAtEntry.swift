//
//  LatestAviReadAtEntry.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct LatestAviAtEntry {
  let eventNames = ["LatestAviAtEntryStart"]
  static let sharedInstance = LatestAviAtEntry()
  
  fileprivate var events: [TKEvent]
  
  fileprivate init() {
    events = [
      TKEvent(name: eventNames[0],
        transitioningFromStates: [WaitingForEntryAvi.sharedInstance.getState()],
        to: WaitingInHoldingLot.sharedInstance.getState())
    ]
  }
}

extension LatestAviAtEntry: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension LatestAviAtEntry: Observable {
  func eventIsFiring(_ info: Any?) {
    if let antenna = info as? Antenna {
      NotificationCenter.default.post(name: .aviRead, object: nil, userInfo: [InfoKey.antenna: antenna])
    }
  }
}
