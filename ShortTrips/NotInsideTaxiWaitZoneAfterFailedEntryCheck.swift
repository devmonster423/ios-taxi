//
//  OutsideTaxiWaitingZoneAfterFailedEntryCheck.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/16/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct NotInsideTaxiWaitZoneAfterFailedEntryCheck {
  let eventNames = ["NotInsideTaxiWaitZoneAfterFailedEntryCheck"]
  static let sharedInstance = NotInsideTaxiWaitZoneAfterFailedEntryCheck()
  
  private var events: [TKEvent]
  
  private init() {
    events = [
      TKEvent(name: eventNames[0],
        transitioningFromStates: [WaitingForEntryCid.sharedInstance.getState(), AssociatingDriverAndVehicleAtEntry.sharedInstance.getState(), WaitingForEntryAvi.sharedInstance.getState()],
        toState: NotReady.sharedInstance.getState())
    ]
  }
}

extension NotInsideTaxiWaitZoneAfterFailedEntryCheck: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
