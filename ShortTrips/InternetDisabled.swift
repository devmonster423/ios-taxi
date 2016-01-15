//
//  InternetDisabled.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/14/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct InternetDisabled {
  let eventNames = ["InternetDisabled"]
  static let sharedInstance = InternetDisabled()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: StateManager.allStates,
      toState: NotReady.sharedInstance.getState())]
  }
}

extension InternetDisabled: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension InternetDisabled: Observable {
  func eventIsFiring(info: Any?) {
    if let tripId = TripManager.sharedInstance.getTripId() {
      ApiClient.invalidate(tripId, validation: .NetworkFailure)
      TripManager.sharedInstance.stop()
    }
  }
}
