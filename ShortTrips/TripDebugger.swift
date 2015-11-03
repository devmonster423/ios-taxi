//
//  TripDebugger.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

protocol TripDebugger { }

extension TripDebugger where Self: DebugVC {
  
  func setupTripObservers() {
    timeExpiredObserver = NotificationObserver(notification: SfoNotification.Trip.timeExpired) { _, _ in
      self.debugView().printDebugLine("Time Expired")
    }
    
    tripStartedObserver = NotificationObserver(notification: SfoNotification.Trip.started) { tripId, _ in
      self.debugView().printDebugLine("Trip started: \(tripId)", type: .Positive)
    }
    
    validationObserver = NotificationObserver(notification: SfoNotification.Trip.validation) { valid, _ in
      if valid {
        self.debugView().printDebugLine("Trip is valid", type: .Positive)
      } else {
        self.debugView().printDebugLine("Trip is invalid", type: .Negative)
      }
    }
    
    warningObserver = NotificationObserver(notification: SfoNotification.Trip.warning) { warning, _ in
      self.debugView().printDebugLine("Trip Warning: \(warning.rawValue)")
    }
  }
}
