//
//  LatestCidIsEntryCid.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/15/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct LatestCidIsEntryCid {
  let eventNames = ["lastestCidIsEntryCid"]
  static let sharedInstance = LatestCidIsEntryCid()

  fileprivate var events: [TKEvent]

  fileprivate init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForEntryCid.sharedInstance.getState()],
      to: AssociatingDriverAndVehicleAtEntry.sharedInstance.getState())]
  }
}

extension LatestCidIsEntryCid: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension LatestCidIsEntryCid: Observable {
  func eventIsFiring(_ info: Any?) {
    if let cid = info as? Cid {
      postNotification(SfoNotification.Cid.entry, value: cid)
    }
  }
}
