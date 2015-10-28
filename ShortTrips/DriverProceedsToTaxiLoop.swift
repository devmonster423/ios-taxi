//
//  DriverProceedsToTaxiLoop.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct DriverProceedsToTaxiLoop {
  let eventNames = ["driverProceedsToTaxiLoop"]
  static let sharedInstance = DriverProceedsToTaxiLoop()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [Valid.sharedInstance.getState()],
      toState: Ready.sharedInstance.getState())]
  }
}

extension DriverProceedsToTaxiLoop: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

