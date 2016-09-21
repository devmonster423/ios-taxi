//
//  NotInsideTaxiLoopExitAfterFailedPaymentCheck.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/16/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct NotInTaxiLoopOrInHoldingLotAfterFailedPaymentCheck {
  let eventNames = ["NotInsideTaxiLoopExitAfterFailedPaymentCheckHoldingLot", "NotInsideTaxiLoopExitAfterFailedPaymentCheckNotReady"]
  static let sharedInstance = NotInTaxiLoopOrInHoldingLotAfterFailedPaymentCheck()
  
  fileprivate var events: [TKEvent]
  
  fileprivate init() {
    let event1 = TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForPaymentCid.sharedInstance.getState(), AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState(), WaitingForTaxiLoopAvi.sharedInstance.getState()],
      to: WaitingInHoldingLot.sharedInstance.getState())
    
    let event2 = TKEvent(name: eventNames[1],
      transitioningFromStates: [WaitingForPaymentCid.sharedInstance.getState(), AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState(), WaitingForTaxiLoopAvi.sharedInstance.getState()],
      to: NotReady.sharedInstance.getState())
    
    event1?.setShouldFire { _, _ -> Bool in
      return AviManager.sharedInstance.latestAviInTaxiEntryOrStatus()
    }
    
    event2?.setShouldFire { _, _ -> Bool in
      return !AviManager.sharedInstance.latestAviInTaxiEntryOrStatus()
    }
    
    events = [event1!, event2!]
  }
}

extension NotInTaxiLoopOrInHoldingLotAfterFailedPaymentCheck: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
