//
//  InsideTaxiWaitingZone.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/7/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct InsideTaxiWaitingZone {
  let eventNames = ["InsideTaxiWaitingZone"]
  static let sharedInstance = InsideTaxiWaitingZone()
  
  private var events: [TKEvent]
  
  private init() {
    
    let insideTaxiWaitingZoneEvent = TKEvent(name: eventNames[0],
      transitioningFromStates: [NotReady.sharedInstance.getState()],
      toState: WaitingForEntryCid.sharedInstance.getState())
    
    insideTaxiWaitingZoneEvent.setShouldFireEventBlock { _, _ -> Bool in
      return LocationManager.locationActiveAndAuthorized()
    }
    
    events = [insideTaxiWaitingZoneEvent]
  }
}

extension InsideTaxiWaitingZone: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
