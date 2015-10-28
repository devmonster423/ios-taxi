//
//  DriverExitsSfo.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct DriverOutsideSfo: Event {
  let eventName = "driverOutsideSfo"
  static let sharedInstance = DriverOutsideSfo()
  
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
