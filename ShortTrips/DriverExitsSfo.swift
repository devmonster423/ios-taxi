//
//  DriverExitsSfo.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct DriverExitsSfo: Event {
  let eventName = "driverExitsSfo"
  static let sharedInstance = DriverExitsSfo()
  
  private var event: TKEvent
  
  private init() {
    event = TKEvent(name: eventName,
      transitioningFromStates: [Ready.sharedInstance.getState()],
      toState: InProgress.sharedInstance.getState())
  }
  
  func getEvent() -> TKEvent {
    return event
  }
}
