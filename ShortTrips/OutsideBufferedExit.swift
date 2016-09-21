//
//  OutsideBufferedExit.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/15/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class OutsideBufferedExit {
  let eventNames = ["OutsideBufferedExit"]
  static let sharedInstance = OutsideBufferedExit()
  
  fileprivate var events: [TKEvent]
  
  fileprivate init() {
    events = [
      TKEvent(name: eventNames[0],
        transitioningFromStates: [
          Ready.sharedInstance.getState()
        ],
        to: WaitingForExitAvi.sharedInstance.getState())
    ]
  }
}

extension OutsideBufferedExit: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension OutsideBufferedExit: Observable {
  func eventIsFiring(_ info: Any?) {
    postNotification(SfoNotification.Geofence.outsideBufferedExit, value: nil)
  }
}
