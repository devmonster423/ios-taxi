//
//  DriverDispatched.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/5/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct InsideTaxiLoopExit {
  let eventNames = ["insideTaxiLoopExit"]
  static let sharedInstance = InsideTaxiLoopExit()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingInHoldingLot.sharedInstance.getState()],
      toState: WaitingForPaymentCID.sharedInstance.getState())]
  }
}

extension InsideTaxiLoopExit: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
