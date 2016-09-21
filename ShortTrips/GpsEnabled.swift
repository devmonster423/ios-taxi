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
  
  fileprivate var events: [TKEvent]
  
  fileprivate init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [GpsIsOff.sharedInstance.getState()],
      to: NotReady.sharedInstance.getState())]
  }
}

extension GpsEnabled: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
