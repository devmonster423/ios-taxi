//
//  LatestAviReadAtEntry.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct LatestAviAtEntry {
  let eventNames = ["LatestAviAtEntryStart"]
  static let sharedInstance = LatestAviAtEntry()
  
  private var events: [TKEvent]
  
  private init() {
    events = [
      TKEvent(name: eventNames[0],
        transitioningFromStates: [WaitingForEntryAvi.sharedInstance.getState()],
        toState: WaitingInHoldingLot.sharedInstance.getState())
    ]
  }
}

extension LatestAviAtEntry: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension LatestAviAtEntry: Observable {
  func eventIsFiring(info: Any?) {
    if let antenna = info as? Antenna {
      postNotification(SfoNotification.Avi.entryGate, value: antenna)
    }
  }
}
