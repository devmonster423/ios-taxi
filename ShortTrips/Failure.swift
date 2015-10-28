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
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: TripManager.allStates,
      toState: NotReady.sharedInstance.getState())]
  }
}

extension Failure: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
