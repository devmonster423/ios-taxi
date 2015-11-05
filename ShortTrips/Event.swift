//
//  Event.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/5/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

protocol Event {
  var eventNames: [String] { get }
  func getEvents() -> [TKEvent]
}

extension Event {
  func fire(userInfo: [NSObject: AnyObject]? = nil) {
    for eventName in eventNames {
      do {
        try StateManager.sharedInstance.getMachine().fireEvent(eventName, userInfo: userInfo)
      } catch {}
    }
  }
}

extension Event where Self:Observable {
  func fire(info: Any? = nil, userInfo: [NSObject: AnyObject]? = nil) {
    eventIsFiring(info)
    
    for eventName in eventNames {
      do {
        try StateManager.sharedInstance.getMachine().fireEvent(eventName, userInfo: userInfo)
      } catch {}
    }
  }
}
