//
//  LatestCidIsPaymentCid.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class LatestCidIsPaymentCid {
  let eventNames = ["latestCidIsPaymentCid"]
  static let sharedInstance = LatestCidIsPaymentCid()
  
  private var events: [TKEvent]

  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForPaymentCID.sharedInstance.getState()],
      toState: VerifyingTaxiLoopAvi.sharedInstance.getState())]
  }
}

extension LatestCidIsPaymentCid: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}