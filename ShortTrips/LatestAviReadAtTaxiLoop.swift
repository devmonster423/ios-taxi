//
//  LatestAviReadAtTaxiLoop.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class LatestAviReadAtTaxiLoop {
  let eventNames = ["latestAviReadAtTaxiLoop"]
  static let sharedInstance = LatestAviReadAtTaxiLoop()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [VerifyingTaxiLoopAVI.sharedInstance.getState()],
      toState: Ready.sharedInstance.getState())]
  }
}

extension LatestAviReadAtTaxiLoop: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}