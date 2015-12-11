//
//  LoggedOut.swift
//  ShortTrips
//
//  Created by Joshua Adams on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct LoggedOut {
  let eventNames = ["loggedOut"]
  static let sharedInstance = LoggedOut()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: StateManager.allStates,
      toState: NotReady.sharedInstance.getState())]
  }
}

extension LoggedOut: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension LoggedOut: Observable {
  func eventIsFiring(info: Any?) {
    if let tripId = TripManager.sharedInstance.getTripId() {
      ApiClient.invalidate(tripId, validation: .UserLogout)
      TripManager.sharedInstance.stop()
    }
  }
}
