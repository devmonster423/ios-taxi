//
//  OptionalCidFailed.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/11/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct OptionalEntryCheckFailed {
  let eventNames = ["optionalEntryCheckFailed"]
  static let sharedInstance = OptionalEntryCheckFailed()

  private var events: [TKEvent]

  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForEntryCid.sharedInstance.getState(),
        AssociatingDriverAndVehicleAtEntry.sharedInstance.getState(),
        VerifyingEntryGateAvi.sharedInstance.getState()],
      toState: WaitingInHoldingLot.sharedInstance.getState())]
  }
}

extension OptionalEntryCheckFailed: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension OptionalEntryCheckFailed: Observable {
  func eventIsFiring(info: Any?) {
    postNotification(SfoNotification.Trip.optionalEntryStepFailed, value: nil)
  }
}
