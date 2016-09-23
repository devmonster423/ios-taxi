//
//  LatestAviAtReEntry.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct LatestAviAtReEntry {
  let eventNames = ["LatestAviAtReEntry"]
  static let sharedInstance = LatestAviAtReEntry()
  
  fileprivate var events: [TKEvent]
  
  fileprivate init() {
    events = [
      TKEvent(name: eventNames[0],
        transitioningFromStates: [WaitingForReEntryAvi.sharedInstance.getState()],
        to: ValidatingTrip.sharedInstance.getState())
    ]
  }
}

extension LatestAviAtReEntry: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension LatestAviAtReEntry: Observable {
  func eventIsFiring(_ info: Any?) {
    if let antenna = info as? Antenna {
      NotificationCenter.default.post(name: .aviRead, object: nil, userInfo: [InfoKey.antenna: antenna])
    }
  }
}
