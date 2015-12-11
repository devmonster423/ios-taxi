//
//  InsideSfoNotExitingTerminals.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/10/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct InsideSfoNotExitingTerminals {
  
  let eventNames = ["InsideSfoNotExitingTerminals"]
  static let sharedInstance = InsideSfoNotExitingTerminals()
  
  private var events: [TKEvent]
  
  private init() {
    events = [
      TKEvent(name: eventNames[0],
        transitioningFromStates: [WaitingForExitAvi.sharedInstance.getState()],
        toState: Ready.sharedInstance.getState())
    ]
  }
}

extension InsideSfoNotExitingTerminals: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
