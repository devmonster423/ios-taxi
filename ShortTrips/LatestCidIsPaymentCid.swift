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
  
  fileprivate var events: [TKEvent]

  fileprivate init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForPaymentCid.sharedInstance.getState()],
      to: AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState())]
  }
}

extension LatestCidIsPaymentCid: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension LatestCidIsPaymentCid: Observable {
  func eventIsFiring(_ info: Any?) {
    if let cid = info as? Cid {
      postNotification(SfoNotification.Cid.payment, value: cid)
    }
  }
}
