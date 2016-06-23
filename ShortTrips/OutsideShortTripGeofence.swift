//
//  OutsideShortTripGeofence.swift
//  ShortTrips
//
//  Created by Joshua Adams on 11/2/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct OutsideShortTripGeofence {
  let eventNames = ["outsideShortTripGeofence"]
  static let sharedInstance = OutsideShortTripGeofence()
  
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: StateManager.allStates,
      toState: NotReady.sharedInstance.getState())]
  }
}

extension OutsideShortTripGeofence: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension OutsideShortTripGeofence: Observable {
  func eventIsFiring(info: Any?) {
    postNotification(SfoNotification.Geofence.outsideShortTrip, value: nil)

    if let tripId = TripManager.sharedInstance.getTripId() {
      ApiClient.invalidate(tripId, invalidation: .Geofence)
      TripManager.sharedInstance.reset(false)
    }
  }
}
