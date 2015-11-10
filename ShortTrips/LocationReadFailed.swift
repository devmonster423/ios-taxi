//
//  LocationReadFailed.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 11/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct LocationReadFailed {
  let eventNames = ["locationReadFailed"]
  static let sharedInstance = LocationReadFailed()

  private var events: [TKEvent]

  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [InProgress.sharedInstance.getState()],
      toState: NotReady.sharedInstance.getState())]
  }
}

extension LocationReadFailed: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension LocationReadFailed: Observable {
  func eventIsFiring(info: Any?) {

  }
}