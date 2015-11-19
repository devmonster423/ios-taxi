//
//  NotInTerminalExit.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/19/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct NotInTerminalExit {
  let eventNames = ["notInTerminalExit"]
  static let sharedInstance = NotInTerminalExit()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [VerifyingExitAvi.sharedInstance.getState()],
      toState: NotReady.sharedInstance.getState())]
  }
}

extension NotInTerminalExit: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension NotInTerminalExit: Observable {
  func eventIsFiring(info: Any?) {
    postNotification(SfoNotification.Geofence.notInTerminalExit, value: nil)
    
    if let tripId = TripManager.sharedInstance.getTripId() {
      ApiClient.invalidate(tripId, validation: .Geofence)
    }
  }
}
