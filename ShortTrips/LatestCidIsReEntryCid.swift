//
//  LatestCidIsReEntryCid.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct LatestCidIsReEntryCid {
  let eventNames = ["lastestCidIsReEntryCid"]
  static let sharedInstance = LatestCidIsReEntryCid()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForReEntryCid.sharedInstance.getState()],
      toState: AssociatingDriverAndVehicleAtReEntry.sharedInstance.getState())]
  }
}

extension LatestCidIsReEntryCid: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension LatestCidIsReEntryCid: Observable {
  func eventIsFiring(info: Any?) {
    if let cid = info as? Cid {
      postNotification(SfoNotification.Cid.entry, value: cid)
    }
  }
}
