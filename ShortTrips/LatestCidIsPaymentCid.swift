//
//  LatestCidIsPaymentCid.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

class LatestCidIsPaymentCid {
  let eventNames = ["latestCidIsPaymentCid"]
  static let sharedInstance = LatestCidIsPaymentCid()
  
  private var events: [TKEvent]

  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForPaymentCid.sharedInstance.getState()],
      toState: VerifyingTaxiLoopAvi.sharedInstance.getState())]
  }
}

extension LatestCidIsPaymentCid: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension LatestCidIsPaymentCid: Notifiable {
  func postSfoNotification(info: Any?) {
    if let cid = info as? Cid {
      postNotification(SfoNotification.Cid.payment, value: cid)
    }
  }
}