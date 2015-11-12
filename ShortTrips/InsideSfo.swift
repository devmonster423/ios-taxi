//
//  EnteredSFOGeofence.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct InsideSfo {
  
  let eventNames = ["enterSfoGeofence", "reEnterSfoGeofence"]
  static let sharedInstance = InsideSfo()

  private var events: [TKEvent]

  private init() {
    events = [
    TKEvent(name: eventNames[0],
      transitioningFromStates: [NotReady.sharedInstance.getState()],
      toState: WaitingForEntryCid.sharedInstance.getState()),
    TKEvent(name: eventNames[1],
        transitioningFromStates: [InProgress.sharedInstance.getState()],
        toState: VerifyingInboundAvi.sharedInstance.getState())
    ]
  }
}

extension InsideSfo: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension InsideSfo: Observable {
  func eventIsFiring(info: Any?) {
    postNotification(SfoNotification.Geofence.insideSfo, value: nil)
  }
}
