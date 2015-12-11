//
//  LatestAviReadAtTaxiLoop.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

class LatestAviAtTaxiLoop {
  let eventNames = ["LatestAviAtTaxiLoop"]
  static let sharedInstance = LatestAviAtTaxiLoop()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingForTaxiLoopAvi.sharedInstance.getState()],
      toState: Ready.sharedInstance.getState())]
  }
}

extension LatestAviAtTaxiLoop: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension LatestAviAtTaxiLoop: Observable {
  func eventIsFiring(info: Any?) {
    if let antenna = info as? Antenna {
      postNotification(SfoNotification.Avi.taxiLoop, value: antenna)
    }
  }
}