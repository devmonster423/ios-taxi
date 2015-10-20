//
//  EnteredSFOGeofence.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct EnteredSFOGeofence: Event {
  let eventName = "enteredSFOGeofence"
  static let sharedInstance = EnteredSFOGeofence()

  private var event: TKEvent

  private init() {
    event = TKEvent(name: eventName,
      transitioningFromStates: [NotReady.sharedInstance.getState()],
      toState: WaitingForEntryCID.sharedInstance.getState())
  }

  func getEvent() -> TKEvent {
    return event
  }
}
