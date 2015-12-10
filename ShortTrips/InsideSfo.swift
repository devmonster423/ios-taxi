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
  
  let eventNames = ["reEnterSfoGeofence"]
  static let sharedInstance = InsideSfo()

  private var events: [TKEvent]

  private init() {
    
    let reEnterSfoGeofenceEvent = TKEvent(name: eventNames[0],
      transitioningFromStates: [InProgress.sharedInstance.getState()],
      toState: WaitingForReEntryAvi.sharedInstance.getState())
    
    events = [reEnterSfoGeofenceEvent]
  }
}

extension InsideSfo: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
