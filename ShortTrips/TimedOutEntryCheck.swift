//
//  TimedOutEntryCheck.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/11/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct TimedOutEntryCheck {
  let eventNames = ["TimedOutEntryCheck"]
  static let sharedInstance = TimedOutEntryCheck()
  
  private var events: [TKEvent]
  
  private init() {
    events = [
      TKEvent(name: eventNames[0],
        transitioningFromStates: [AssociatingDriverAndVehicleAtEntry.sharedInstance.getState(),
          WaitingForEntryAvi.sharedInstance.getState()],
        toState: NotReady.sharedInstance.getState())
    ]
  }
}

extension TimedOutEntryCheck: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
