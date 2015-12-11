//
//  TimedOutReEntryCheck.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/11/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct TimedOutReEntryCheck {
  let eventNames = ["TimedOutReEntryCheck"]
  static let sharedInstance = TimedOutReEntryCheck()
  
  private var events: [TKEvent]
  
  private init() {
    events = [
      TKEvent(name: eventNames[0],
        transitioningFromStates: [AssociatingDriverAndVehicleAtReEntry.sharedInstance.getState(),
          WaitingForReEntryCid.sharedInstance.getState()],
        toState: InProgress.sharedInstance.getState())
    ]
  }
}

extension TimedOutReEntryCheck: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
