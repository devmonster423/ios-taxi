//
//  DriverProceedsToTaxiLoop.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct DriverProceedsToTaxiLoop: Event {
  let eventName = "driverProceedsToTaxiLoop"
  static let sharedInstance = DriverProceedsToTaxiLoop()
  
  private var event: TKEvent
  
  private init() {
    event = TKEvent(name: eventName,
      transitioningFromStates: [Valid.sharedInstance.getState()],
      toState: Ready.sharedInstance.getState())
  }
  
  func getEvent() -> TKEvent {
    return event
  }
}

