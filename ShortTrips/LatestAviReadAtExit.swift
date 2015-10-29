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

class LatestAviReadAtExit {
  let eventNames = ["latestAviReadAtExit"]
  static let sharedInstance = LatestAviReadAtExit()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [VerifyingExitAvi.sharedInstance.getState()],
      toState: WaitingForStartTrip.sharedInstance.getState())]
  }
}

extension LatestAviReadAtExit: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension LatestAviReadAtExit: Notifiable {
  func postSfoNotification(info: Any?) {
    if let antenna = info as? Antenna {
      postNotification(SfoNotification.Avi.exit, value: antenna)
    }
  }
}
