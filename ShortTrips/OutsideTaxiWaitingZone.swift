//
//  OutsideTaxiWaitingZone.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct OutsideTaxiWaitingZone {
  let eventNames = ["OutsideTaxiWaitingZone"]
  static let sharedInstance = OutsideTaxiWaitingZone()
  
  private var events: [TKEvent]
  
  private init() {
    events = [
      TKEvent(name: eventNames[0],
        transitioningFromStates: [WaitingForEntryCid.sharedInstance.getState(), WaitingInHoldingLot.sharedInstance.getState()],
        toState: NotReady.sharedInstance.getState())
    ]
  }
}

extension OutsideTaxiWaitingZone: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
