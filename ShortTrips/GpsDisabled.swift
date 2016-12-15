//
//  LocationReadFailed.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 11/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct GpsDisabled {
  let eventNames = ["gpsDisabled"]
  static let sharedInstance = GpsDisabled()

  fileprivate var events: [TKEvent]

  fileprivate init() {
    
    let event = TKEvent(name: eventNames[0],
      transitioningFromStates: StateManager.allStates,
      to: GpsIsOff.sharedInstance.getState())
    
    events = [event!]
  }
}

extension GpsDisabled: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension GpsDisabled: Observable {
  func eventIsFiring(_ info: Any?) {
    if let tripId = TripManager.sharedInstance.getTripId(),
      let sessionId = DriverManager.sharedInstance.getCurrentDriver()?.sessionId {

      DriverManager.sharedInstance.callWithValidSession {
        ApiClient.invalidate(tripId, invalidation: .gpsFailure, sessionId: sessionId)
      }
      TripManager.sharedInstance.reset(false)
    }
  }
}
