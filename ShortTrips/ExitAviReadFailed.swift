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

class ExitAviReadFailed {
  let eventNames = ["exitAviReadFailed"]
  static let sharedInstance = ExitAviReadFailed()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [VerifyingExitAvi.sharedInstance.getState()],
      toState: WaitingForStartTrip.sharedInstance.getState())]
  }
}

extension ExitAviReadFailed: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension ExitAviReadFailed: Observable {
  func eventWasFired(info: Any?) {
    postNotification(SfoNotification.Trip.warning, value: .ExitAviFailed)
  }
}
