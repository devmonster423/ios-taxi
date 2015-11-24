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

struct OptionalInboundAviFailed {
  let eventNames = ["optionalInboundAviFailed"]
  static let sharedInstance = OptionalInboundAviFailed()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [VerifyingInboundAvi.sharedInstance.getState()],
      toState: InProgress.sharedInstance.getState())]
  }
}

extension OptionalInboundAviFailed: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension OptionalInboundAviFailed: Observable {
  func eventIsFiring(info: Any?) {
    postNotification(SfoNotification.Trip.inboundStepFailed, value: nil)
  }
}
