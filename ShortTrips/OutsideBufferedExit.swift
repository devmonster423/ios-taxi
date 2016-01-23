//
//  OutsideBufferedExit.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/15/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

class OutsideBufferedExit {
  let eventNames = ["OutsideBufferedExit"]
  static let sharedInstance = OutsideBufferedExit()
  
  private var events: [TKEvent]
  
  private init() {
    events = [
      TKEvent(name: eventNames[0],
        transitioningFromStates: [
          Ready.sharedInstance.getState(),
          WaitingForExitAvi.sharedInstance.getState(),
          TripStartPending.sharedInstance.getState()
        ],
        toState: StartingTrip.sharedInstance.getState())
    ]
  }
}

extension OutsideBufferedExit: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension OutsideBufferedExit: Observable {
  func eventIsFiring(info: Any?) {
    postNotification(SfoNotification.Geofence.outsideBufferedExit, value: nil)
  }
}
