//
//  DriverReturnsToSfo1.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct DriverReturnsToSfo: Event {
  let eventName = "driverReturnsToSfo"
  static let sharedInstance = DriverReturnsToSfo()
  
  private var event: TKEvent
  
  private init() {
    event = TKEvent(name: eventName,
      transitioningFromStates: [InProgress.sharedInstance.getState()],
      toState: Validating.sharedInstance.getState())
  }
  
  func getEvent() -> TKEvent {
    return event
  }
}
