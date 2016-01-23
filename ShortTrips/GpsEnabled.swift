//
//  GpsEnabled.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/22/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct GpsEnabled {
  let eventNames = ["GpsEnabled"]
  static let sharedInstance = GpsEnabled()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [GpsIsOff.sharedInstance.getState()],
      toState: NotReady.sharedInstance.getState())]
  }
}

extension GpsEnabled: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
