//
//  LatestAviAtReEntry.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct LatestAviAtReEntry {
  let eventNames = ["LatestAviAtReEntry"]
  static let sharedInstance = LatestAviAtReEntry()
  
  private var events: [TKEvent]
  
  private init() {
    events = [
      TKEvent(name: eventNames[0],
        transitioningFromStates: [WaitingForReEntryAvi.sharedInstance.getState()],
        toState: WaitingForReEntryCid.sharedInstance.getState())
    ]
  }
}

extension LatestAviAtReEntry: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension LatestAviAtReEntry: Observable {
  func eventIsFiring(info: Any?) {
    if let antenna = info as? Antenna {
      postNotification(SfoNotification.Avi.entryGate, value: antenna)
    }
  }
}
