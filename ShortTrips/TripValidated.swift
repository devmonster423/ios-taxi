//
//  DriverReturnsToSfo2.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct TripValidated: Event {
  let eventName = "tripValidated"
  static let sharedInstance = TripValidated()
  
  private var event: TKEvent
  
  private init() {
    event = TKEvent(name: eventName,
      transitioningFromStates: [Validating.sharedInstance.getState()],
      toState: Valid.sharedInstance.getState())
  }
  
  func getEvent() -> TKEvent {
    return event
  }
}
