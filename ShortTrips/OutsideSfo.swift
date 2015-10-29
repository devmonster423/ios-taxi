//
//  DriverExitsSfo.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct OutsideSfo {
  let eventNames = ["outsideSfo"]
  static let sharedInstance = OutsideSfo()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [Ready.sharedInstance.getState()],
      toState: VerifyingExitAvi.sharedInstance.getState())]
  }
}

extension OutsideSfo: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
