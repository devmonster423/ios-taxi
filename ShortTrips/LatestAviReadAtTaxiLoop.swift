//
//  LatestAviReadAtTaxiLoop.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class LatestAviReadAtTaxiLoop: Event {
  let eventName = "latestAviReadAtTaxiLoop"
  static let sharedInstance = LatestAviReadAtTaxiLoop()
  
  private var event: TKEvent
  
  private init() {
    event = TKEvent(name: eventName,
      transitioningFromStates: [VerifyingTaxiLoopAVI.sharedInstance.getState()],
      toState: Ready.sharedInstance.getState())
  }
  
  func getEvent() -> TKEvent {
    return event
  }

}