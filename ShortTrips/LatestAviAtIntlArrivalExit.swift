//
//  LatestAviAtIntlArrivalExit.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/8/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

class LatestAviAtIntlArrivalExit {
  let eventNames = ["LatestAviAtIntlArrivalExit"]
  static let sharedInstance = LatestAviAtIntlArrivalExit()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForExitAvi.sharedInstance.getState()],
      toState: WaitingForDomesticReEntryAvi.sharedInstance.getState())]
  }
}

extension LatestAviAtIntlArrivalExit: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension LatestAviAtIntlArrivalExit: Observable {
  func eventIsFiring(info: Any?) {
    if let antenna = info as? Antenna {
      TripManager.sharedInstance.setStartTime(antenna.aviDate)
      postNotification(SfoNotification.Avi.intlArrivalExit, value: antenna)
    }
  }
}
