//
//  TripStarted.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/28/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct TripStarted {
  let eventNames = ["tripStarted"]
  static let sharedInstance = TripStarted()
  
  fileprivate var events: [TKEvent]
  
  fileprivate init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [StartingTrip.sharedInstance.getState()],
      to: InProgress.sharedInstance.getState())]
  }
}

extension TripStarted: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension TripStarted: Observable {
  func eventIsFiring(_ info: Any?) {
    
    if let info = info as? Int {
      postNotification(SfoNotification.Trip.started, value: info)
    }
  }
}
