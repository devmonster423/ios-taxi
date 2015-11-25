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
  let eventNames = ["entryGateAVIReadConfirmedStart", "entryGateAVIReadConfirmedEnd"]
  static let sharedInstance = EntryGateAVIReadConfirmed()
  
  private var events: [TKEvent]
  
  private init() {
    
    let tripStartEvent = TKEvent(name: eventNames[0],
      transitioningFromStates: [VerifyingEntryGateAvi.sharedInstance.getState()],
      toState: WaitingInHoldingLot.sharedInstance.getState())
    
    tripStartEvent.setShouldFireEventBlock { _, _ -> Bool in
      return TripManager.sharedInstance.getTripId() == nil
    }
    
    let tripEndEvent = TKEvent(name: eventNames[1],
      transitioningFromStates: [VerifyingEntryGateAvi.sharedInstance.getState()],
      toState: WaitingForEntryCid.sharedInstance.getState())
    
    tripEndEvent.setShouldFireEventBlock { _, _ -> Bool in
      return TripManager.sharedInstance.getTripId() != nil
    }
    
    events = [tripStartEvent, tripEndEvent]
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
