//
//  DriverReturnsToSfo2.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct TripValidated {
  let eventNames = ["tripValidated"]
  static let sharedInstance = TripValidated()
  
  fileprivate var events: [TKEvent]
  
  fileprivate init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [ValidatingTrip.sharedInstance.getState()],
      to: WaitingInHoldingLot.sharedInstance.getState())]
  }
}

extension TripValidated: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension TripValidated: Observable {
  func eventIsFiring(_ info: Any?) {
    postNotification(SfoNotification.Trip.validated, value: Date())
    TripManager.sharedInstance.reset(true)
  }
}
