//
//  NotInsideTaxiLoopExitAfterFailedPaymentCheck.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/16/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct NotInTaxiLoopOrInHoldingLotAfterFailedPaymentCheck {
  let eventNames = ["NotInsideTaxiLoopExitAfterFailedPaymentCheckHoldingLot", "NotInsideTaxiLoopExitAfterFailedPaymentCheckNotReady"]
  static let sharedInstance = NotInTaxiLoopOrInHoldingLotAfterFailedPaymentCheck()
  
  private var events: [TKEvent]
  
  private init() {
    let event1 = TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForPaymentCid.sharedInstance.getState(), AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState(), WaitingForTaxiLoopAvi.sharedInstance.getState()],
      toState: WaitingInHoldingLot.sharedInstance.getState())
    
    let event2 = TKEvent(name: eventNames[1],
      transitioningFromStates: [WaitingForPaymentCid.sharedInstance.getState(), AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState(), WaitingForTaxiLoopAvi.sharedInstance.getState()],
      toState: NotReady.sharedInstance.getState())
    
    event1.setShouldFireEventBlock { _, _ -> Bool in
      return AviManager.sharedInstance.latestAviInTaxiEntryOrStatus()
    }
    
    event2.setShouldFireEventBlock { _, _ -> Bool in
      return !AviManager.sharedInstance.latestAviInTaxiEntryOrStatus()
    }
    
    events = [event1, event2]
  }
}

extension NotInTaxiLoopOrInHoldingLotAfterFailedPaymentCheck: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
