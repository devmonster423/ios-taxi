//
//  AppQuit.swift
//  ShortTrips
//
//  Created by Joshua Adams on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct AppQuit {
  let eventNames = ["appQuit"]
  static let sharedInstance = AppQuit()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: StateManager.allStates,
      toState: NotReady.sharedInstance.getState())]
  }
}

extension AppQuit: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension AppQuit: Observable {
  func eventIsFiring(info: Any?) {
    if let tripId = TripManager.sharedInstance.getTripId() {
      ApiClient.invalidate(tripId, validation: ValidationStepWrapper(validationStep: .InvalidGeofence))
    }
  }
}
