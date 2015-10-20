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
  var eventName: String { get }
}

extension Event {
  func fire() {
    do {
      try TripManager.sharedInstance.getMachine().fireEvent(eventName, userInfo: nil)
    } catch {}
  }

  func fire(info: [NSObject: AnyObject]?) {
    do {
      try TripManager.sharedInstance.getMachine().fireEvent(eventName, userInfo: info)
    } catch {}
  }
}
