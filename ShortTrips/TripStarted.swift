//
//  TripStarted.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/28/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct TripStarted {
  let eventNames = ["tripStarted"]
  static let sharedInstance = TripStarted()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForStartTrip.sharedInstance.getState()],
      toState: InProgress.sharedInstance.getState())]
  }
}

extension TripStarted: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension TripStarted: Observable {
  func eventIsFiring(info: Any?) {
    if let info = info as? Int {
      TripManager.sharedInstance.setTripId(info)
      postNotification(SfoNotification.Trip.started, value: info)
    }
  }
}
