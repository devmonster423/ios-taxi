//
//  TimeExpired.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/30/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct TimeExpired {
  let eventNames = ["timeExpired"]
  static let sharedInstance = TimeExpired()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [InProgress.sharedInstance.getState()],
      toState: NotReady.sharedInstance.getState())]
  }
}

extension TimeExpired: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension TimeExpired: Notifiable {
  func postSfoNotification(info: Any?) {
    postNotification(SfoNotification.Trip.timeExpired, value: nil)
  }
}
