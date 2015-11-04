//
//  EntryGateAVIReadConfirmed.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct EntryGateAVIReadConfirmed {
  let eventNames = ["entryGateAVIReadConfirmed"]
  static let sharedInstance = EntryGateAVIReadConfirmed()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
    transitioningFromStates: [VerifyingEntryGateAvi.sharedInstance.getState()],
    toState: WaitingInHoldingLot.sharedInstance.getState())]
  }
}

extension EntryGateAVIReadConfirmed: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension EntryGateAVIReadConfirmed: Observable {
  func eventIsFiring(info: Any?) {
    if let antenna = info as? Antenna {
      postNotification(SfoNotification.Avi.entryGate, value: antenna)
    }
  }
}
