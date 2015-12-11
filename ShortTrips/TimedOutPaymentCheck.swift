//
//  TimedOutPaymentCheck.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/11/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct TimedOutPaymentCheck {
  let eventNames = ["TimedOutPaymentCheck"]
  static let sharedInstance = TimedOutPaymentCheck()
  
  private var events: [TKEvent]
  
  private init() {
    events = [
      TKEvent(name: eventNames[0],
        transitioningFromStates: [AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState(),
          WaitingForTaxiLoopAvi.sharedInstance.getState()],
        toState: WaitingInHoldingLot.sharedInstance.getState())
    ]
  }
}

extension TimedOutPaymentCheck: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
