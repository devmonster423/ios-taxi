//
//  NotInDomesticExit.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct NotInDomesticExit {
  let eventNames = ["NotInDomesticExit"]
  static let sharedInstance = NotInDomesticExit()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForPaymentCid.sharedInstance.getState()],
      toState: WaitingInHoldingLot.sharedInstance.getState())]
  }
}

extension NotInDomesticExit: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
