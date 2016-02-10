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

class ExitAviCheckComplete {
  let eventNames = ["ExitAviCheckComplete"]
  static let sharedInstance = ExitAviCheckComplete()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForExitAvi.sharedInstance.getState()],
      toState: StartingTrip.sharedInstance.getState())]
  }
}

extension ExitAviCheckComplete: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension ExitAviCheckComplete: Observable {
  func eventIsFiring(info: Any?) {
    if let antenna = info as? Antenna {
      TripManager.sharedInstance.setStartTime(antenna.aviDate)
      postNotification(SfoNotification.Avi.domExit, value: antenna)
    }
  }
}
