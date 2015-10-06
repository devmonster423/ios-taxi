//
//  DriverDispatched.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/5/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct DriverDispatched: Event {
  let eventName = "driverDispatched"
  static let sharedInstance = DriverDispatched()
  
  private var event: TKEvent
  
  private init() {
    event = TKEvent(name: eventName,
      transitioningFromStates: [NotReady.sharedInstance.getState()],
      toState: Ready.sharedInstance.getState())
  }
  
  func getEvent() -> TKEvent {
    return event
  }
}
