//
//  OutsideTaxiWaitingZone.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct OutsideTaxiWaitZone {
  let eventNames = ["OutsideTaxiWaitZone"]
  static let sharedInstance = OutsideTaxiWaitZone()
  
  fileprivate var events: [TKEvent]
  
  fileprivate init() {
    events = [
      TKEvent(name: eventNames[0],
        transitioningFromStates: [WaitingInHoldingLot.sharedInstance.getState()],
        to: NotReady.sharedInstance.getState())
    ]
  }
}

extension OutsideTaxiWaitZone: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
