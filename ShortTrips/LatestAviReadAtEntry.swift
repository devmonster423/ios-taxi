//
//  LatestAviReadAtEntry.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct LatestAviReadAtEntry {
  let eventNames = ["LatestAviReadAtEntryStart", "LatestAviReadAtEntryEnd"]
  static let sharedInstance = LatestAviReadAtEntry()
  
  private var events: [TKEvent]
  
  private init() {
    
    let tripStartEvent = TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForEntryAvi.sharedInstance.getState()],
      toState: WaitingInHoldingLot.sharedInstance.getState())
    
    tripStartEvent.setShouldFireEventBlock { _, _ -> Bool in
      return TripManager.sharedInstance.getTripId() == nil
    }
    
    let tripEndEvent = TKEvent(name: eventNames[1],
      transitioningFromStates: [WaitingForEntryAvi.sharedInstance.getState()],
      toState: WaitingForEntryCid.sharedInstance.getState())
    
    tripEndEvent.setShouldFireEventBlock { _, _ -> Bool in
      return TripManager.sharedInstance.getTripId() != nil
    }
    
    events = [tripStartEvent, tripEndEvent]
  }
}

extension LatestAviReadAtEntry: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension LatestAviReadAtEntry: Observable {
  func eventIsFiring(info: Any?) {
    if let antenna = info as? Antenna {
      postNotification(SfoNotification.Avi.entryGate, value: antenna)
    }
  }
}
