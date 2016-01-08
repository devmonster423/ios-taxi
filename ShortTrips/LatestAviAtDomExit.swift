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

class LatestAviAtDomExit {
  let eventNames = ["LatestAviAtDomExit"]
  static let sharedInstance = LatestAviAtDomExit()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForExitAvi.sharedInstance.getState()],
      toState: WaitingForStartTrip.sharedInstance.getState())]
  }
}

extension LatestAviAtDomExit: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension LatestAviAtDomExit: Observable {
  func eventIsFiring(info: Any?) {
    if let antenna = info as? Antenna {
      TripManager.sharedInstance.setStartTime(antenna.aviDate)
      postNotification(SfoNotification.Avi.domExit, value: antenna)
    }
  }
}
