//
//  ExitedTerminal.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/19/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct ExitingTerminals {
  let eventNames = ["exitingTerminals"]
  static let sharedInstance = ExitingTerminals()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [Ready.sharedInstance.getState()],
      toState: WaitingForExitAvi.sharedInstance.getState())]
  }
}

extension ExitingTerminals: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension ExitingTerminals: Observable {
  func eventIsFiring(info: Any?) {
    postNotification(SfoNotification.Geofence.exitingTerminals, value: nil)
  }
}
