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
  let eventNames = ["lastestCidIsEntryCid"]
  static let sharedInstance = LatestCidIsEntryCid()

  private var events: [TKEvent]

  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForEntryCid.sharedInstance.getState()],
      toState: AssociatingDriverAndVehicle.sharedInstance.getState())]
  }
  
  func getEvents() -> [TKEvent] {
    return events
  }
}
