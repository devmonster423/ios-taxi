//
//  LatestAviReadAtExit.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/29/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class ExitAviCheckComplete {
  let eventNames = ["ExitAviCheckComplete"]
  static let sharedInstance = ExitAviCheckComplete()
  
  fileprivate var events: [TKEvent]
  
  fileprivate init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForExitAvi.sharedInstance.getState()],
      to: StartingTrip.sharedInstance.getState())]
  }
}

extension ExitAviCheckComplete: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension ExitAviCheckComplete: Observable {
  func eventIsFiring(_ info: Any?) {
    if let antenna = info as? Antenna {
      TripManager.sharedInstance.setStartTime(antenna.aviDate)
      NotificationCenter.default.post(name: .aviRead, object: nil, userInfo: [InfoKey.antenna: antenna])
    }
  }
}
