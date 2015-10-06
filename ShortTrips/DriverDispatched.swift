//
//  DriverDispatched.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/5/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct DriverDispatched {
  let eventName = "notReady"
  static let sharedInstance = DriverDispatched()
  
  private var event: TKEvent
  
  private init() {
    event = TKEvent(name: eventName,
      transitioningFromStates: [NotReady.sharedInstance.getState()],
      toState: Ready.sharedInstance.getState())
  }
  
  func getEvent() -> TKEvent {
    return event
  }
  
  func fire(info: [NSObject: AnyObject]?) {
    do {
      try TripManager.sharedInstance.getMachine().fireEvent(eventName, userInfo: info)
    } catch {}
  }
}
