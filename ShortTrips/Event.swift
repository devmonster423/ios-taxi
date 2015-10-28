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
        try TripManager.sharedInstance.getMachine().fireEvent(eventName, userInfo: userInfo)
      } catch {}
    }
  }
}

extension Event where Self:Notifiable {
  func fire(info: Any? = nil, userInfo: [NSObject: AnyObject]? = nil) {
    for eventName in eventNames {
      do {
        try TripManager.sharedInstance.getMachine().fireEvent(eventName, userInfo: userInfo)
      } catch {}
    }
    
    postSfoNotification(info)
  }
}
