//
//  NotInsideSfoAfterFailedReEntryCheck.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/16/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct NotInsideSfoAfterFailedReEntryCheck {
  let eventNames = ["NotInsideSfoAfterFailedReEntryCheck"]
  static let sharedInstance = NotInsideSfoAfterFailedReEntryCheck()
  
  fileprivate var events: [TKEvent]
  
  fileprivate init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForReEntryAvi.sharedInstance.getState(), AssociatingDriverAndVehicleAtReEntry.sharedInstance.getState(), WaitingForReEntryCid.sharedInstance.getState()],
      to: InProgress.sharedInstance.getState())]
  }
}

extension NotInsideSfoAfterFailedReEntryCheck: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
