//
//  InboundAviReadConfirmed.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/30/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

class LatestAviReadInbound {
  let eventNames = ["latestAviReadInbound"]
  static let sharedInstance = LatestAviReadInbound()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [VerifyingInboundAvi.sharedInstance.getState()],
      toState: ValidatingTrip.sharedInstance.getState())]
  }
}

extension LatestAviReadInbound: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension LatestAviReadInbound: Observable {
  func eventWasFired(info: Any?) {
    if let antenna = info as? Antenna {
      postNotification(SfoNotification.Avi.inbound, value: antenna)
    }
  }
}
