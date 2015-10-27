//
//  EntryGateAVIReadConfirmed.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct EntryGateAVIReadConfirmed: Event {
  let eventName = "entryGateAVIReadConfirmed"
  static let sharedInstance = EntryGateAVIReadConfirmed()
  
  private var event: TKEvent
  
  private init() {
    event = TKEvent(name: eventName,
    transitioningFromStates: [VerifyingEntryGateAVI.sharedInstance.getState()],
    toState: WaitingInHoldingLot.sharedInstance.getState())
  }
  
  func getEvent() -> TKEvent {
    return event
  }
}
