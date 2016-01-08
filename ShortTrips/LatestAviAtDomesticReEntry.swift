//
//  LatestAviAtDomesticReEntry.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/8/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct LatestAviAtDomesticReEntry {
  let eventNames = ["LatestAviAtDomesticReEntry"]
  static let sharedInstance = LatestAviAtDomesticReEntry()
  
  private var events: [TKEvent]
  
  private init() {
    events = [
      TKEvent(name: eventNames[0],
        transitioningFromStates: [WaitingForDomesticReEntryAvi.sharedInstance.getState()],
        toState: Ready.sharedInstance.getState())
    ]
  }
}

extension LatestAviAtDomesticReEntry: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension LatestAviAtDomesticReEntry: Observable {
  func eventIsFiring(info: Any?) {
    if let antenna = info as? Antenna {
      postNotification(SfoNotification.Avi.domesticReEntry, value: antenna)
    }
  }
}
