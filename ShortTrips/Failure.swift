//
//  Failure.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/16/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct Failure {
  let eventNames = ["failure"]
  static let sharedInstance = Failure()
  
  fileprivate var events: [TKEvent]
  
  fileprivate init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: StateManager.allStates,
      to: NotReady.sharedInstance.getState())]
  }
}

extension Failure: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
