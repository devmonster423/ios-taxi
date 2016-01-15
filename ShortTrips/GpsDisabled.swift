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

struct GpsDisabled {
  let eventNames = ["gpsDisabled"]
  static let sharedInstance = GpsDisabled()

  private var events: [TKEvent]

  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: StateManager.allStates,
      toState: NotReady.sharedInstance.getState())]
  }
}

extension GpsDisabled: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension GpsDisabled: Observable {
  func eventIsFiring(info: Any?) {
    if let tripId = TripManager.sharedInstance.getTripId() {
      ApiClient.invalidate(tripId, validation: .GpsFailure)
      TripManager.sharedInstance.stop()
    }
  }
}
