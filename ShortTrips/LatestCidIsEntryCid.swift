//
//  LatestCidIsEntryCid.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/15/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct LatestCidIsEntryCid: Event {
  let eventName = "lastestCidIsEntryCid"
  static let sharedInstance = LatestCidIsEntryCid()

  private var event: TKEvent

  private init() {
    event = TKEvent(name: eventName,
      transitioningFromStates: [WaitingForEntryCID.sharedInstance.getState()],
      toState: AssociatingDriverAndVehicle.sharedInstance.getState())
  }

  func getEvent() -> TKEvent {
    return event
  }
}
