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

struct NotInsideTaxiLoopExitAfterFailedPaymentCheck {
  let eventNames = ["NotInsideTaxiLoopExitAfterFailedPaymentCheck"]
  static let sharedInstance = NotInsideTaxiLoopExitAfterFailedPaymentCheck()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForPaymentCid.sharedInstance.getState(), AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState(), WaitingForTaxiLoopAvi.sharedInstance.getState()],
      toState: WaitingInHoldingLot.sharedInstance.getState())]
  }
}

extension NotInsideTaxiLoopExitAfterFailedPaymentCheck: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
