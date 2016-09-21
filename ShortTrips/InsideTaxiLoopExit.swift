//
//  InsideTaxiLoopExit.swift
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
  
  fileprivate var events: [TKEvent]
  
  fileprivate init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [
        WaitingInHoldingLot.sharedInstance.getState(),
        NotReady.sharedInstance.getState(),
        WaitingForEntryCid.sharedInstance.getState(),
        AssociatingDriverAndVehicleAtEntry.sharedInstance.getState(),
        WaitingForEntryAvi.sharedInstance.getState()],
      to: WaitingForPaymentCid.sharedInstance.getState())]
  }
}

extension InsideTaxiLoopExit: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
