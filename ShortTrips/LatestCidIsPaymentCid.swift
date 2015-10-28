//
//  LatestCidIsPaymentCid.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class LatestCidIsPaymentCid: Event {
  let eventName = "latestCidIsPaymentCid"
  static let sharedInstance = LatestCidIsPaymentCid()
  
  private var event: TKEvent

  private init() {
    event = TKEvent(name: eventName,
      transitioningFromStates: [WaitingForPaymentCID.sharedInstance.getState()],
      toState: VerifyingTaxiLoopAVI.sharedInstance.getState())
  }
  
  func getEvent() -> TKEvent {
    return event
  }
}