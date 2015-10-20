//
//  Failure.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/16/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct Failure: Event {
  let eventName = "failure"
  static let sharedInstance = Failure()
  
  private var event: TKEvent
  
  private init() {
    event = TKEvent(name: eventName,
      transitioningFromStates: TripManager.allStates,
      toState: NotReady.sharedInstance.getState())
  }
  
  func getEvent() -> TKEvent {
    return event
  }
}
