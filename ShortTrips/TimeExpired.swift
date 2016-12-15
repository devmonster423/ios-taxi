//
//  TimeExpired.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/30/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct TimeExpired {
  let eventNames = ["timeExpired"]
  static let sharedInstance = TimeExpired()
  
  fileprivate var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: StateManager.allStates,
      to: NotReady.sharedInstance.getState())]
  }
}

extension TimeExpired: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension TimeExpired: Observable {
  func eventIsFiring(_ info: Any?) {
    
    NotificationCenter.default.post(name: .timeExpired, object: nil)

    if let tripId = TripManager.sharedInstance.getTripId(),
      let sessionId = DriverManager.sharedInstance.getCurrentDriver()?.sessionId {

      DriverManager.sharedInstance.callWithValidSession {
        ApiClient.invalidate(tripId, invalidation: .duration, sessionId: sessionId)
      }
      TripManager.sharedInstance.reset(false)
    }
  }
}
