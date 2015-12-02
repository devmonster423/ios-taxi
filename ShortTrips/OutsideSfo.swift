//
//  ExitAviReadFailed.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/29/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

class OutsideSfo {
  let eventNames = ["OutsideSfo"]
  static let sharedInstance = OutsideSfo()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [VerifyingExitAvi.sharedInstance.getState()],
      toState: WaitingForStartTrip.sharedInstance.getState())]
  }
}

extension OutsideSfo: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension OutsideSfo: Observable {
  func eventIsFiring(info: Any?) {
    postNotification(SfoNotification.Geofence.outsideSfo, value: nil)
  }
}
