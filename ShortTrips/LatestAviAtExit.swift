//
//  LatestAviReadAtExit.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/29/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

class LatestAviAtExit {
  let eventNames = ["LatestAviAtExit"]
  static let sharedInstance = LatestAviAtExit()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForExitAvi.sharedInstance.getState()],
      toState: WaitingForStartTrip.sharedInstance.getState())]
  }
}

extension LatestAviAtExit: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension LatestAviAtExit: Observable {
  func eventIsFiring(info: Any?) {
    if let antenna = info as? Antenna {
      TripManager.sharedInstance.setStartTime(antenna.aviDate)
      postNotification(SfoNotification.Avi.exit, value: antenna)
    }
  }
}
