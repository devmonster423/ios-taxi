//
//  OptionalInboundAviFailed.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/19/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct ReEntryAviFailed {
  let eventNames = ["reEntryAviFailed"]
  static let sharedInstance = ReEntryAviFailed()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [VerifyingEntryGateAvi.sharedInstance.getState()],
      toState: InProgress.sharedInstance.getState())]
  }
}

extension ReEntryAviFailed: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension ReEntryAviFailed: Observable {
  func eventIsFiring(info: Any?) {
    postNotification(SfoNotification.Trip.reEntryAviFailed, value: nil)
  }
}
