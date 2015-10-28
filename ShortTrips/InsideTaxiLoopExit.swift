//
//  DriverDispatched.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/5/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct InsideTaxiLoopExit: Event {
  let eventName = "insideTaxiLoopExit"
  static let sharedInstance = InsideTaxiLoopExit()
  
  private var event: TKEvent
  
  private init() {
    event = TKEvent(name: eventName,
      transitioningFromStates: [WaitingInHoldingLot.sharedInstance.getState()],
      toState: WaitingForPaymentCID.sharedInstance.getState())
  }
  
  func getEvent() -> TKEvent {
    return event
  }
}
