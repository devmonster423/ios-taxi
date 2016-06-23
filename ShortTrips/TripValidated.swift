//
//  DriverReturnsToSfo2.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct TripValidated {
  let eventNames = ["tripValidated"]
  static let sharedInstance = TripValidated()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [ValidatingTrip.sharedInstance.getState()],
      toState: WaitingInHoldingLot.sharedInstance.getState())]
  }
}

extension TripValidated: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension TripValidated: Observable {
  func eventIsFiring(info: Any?) {
    postNotification(SfoNotification.Trip.validated, value: NSDate())
    TripManager.sharedInstance.reset()
  }
}
