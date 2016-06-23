//
//  TripInvalidated.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/30/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct TripInvalidated {
  let eventNames = ["tripInvalidated"]
  static let sharedInstance = TripInvalidated()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [ValidatingTrip.sharedInstance.getState()],
      toState: NotReady.sharedInstance.getState())]
  }
}

extension TripInvalidated: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension TripInvalidated: Observable {
  func eventIsFiring(info: Any?) {
    if let info = info as? [ValidationStepWrapper]? {
      postNotification(SfoNotification.Trip.invalidated, value: info)
      TripManager.sharedInstance.reset(false)
    }
  }
}
