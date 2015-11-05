//
//  LatestCidIsEntryCid.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/15/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct LatestCidIsEntryCid {
  let eventNames = ["lastestCidIsEntryCid"]
  static let sharedInstance = LatestCidIsEntryCid()

  private var events: [TKEvent]

  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForEntryCid.sharedInstance.getState()],
      toState: AssociatingDriverAndVehicle.sharedInstance.getState())]
  }
}

extension LatestCidIsEntryCid: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension LatestCidIsEntryCid: Observable {
  func eventIsFiring(info: Any?) {
    if let cid = info as? Cid {
      postNotification(SfoNotification.Cid.entry, value: cid)
    }
  }
}