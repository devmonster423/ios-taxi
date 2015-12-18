//
//  TripDebugger.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

extension DebugVC {
  
  func setupTripObservers() {

    sfoObservers.timeExpiredObserver = NotificationObserver(notification: SfoNotification.Trip.timeExpired) { _, _ in
      self.debugView().printDebugLine("Time Expired")
    }
    
    sfoObservers.tripStartedObserver = NotificationObserver(notification: SfoNotification.Trip.started) { tripId, _ in
      self.debugView().printDebugLine("Trip started: \(tripId)", type: .Positive)
    }
    
    sfoObservers.validatedObserver = NotificationObserver(notification: SfoNotification.Trip.validated) { _, _ in
      self.debugView().printDebugLine("Trip is valid", type: .Positive)
    }
    
    sfoObservers.invalidatedObserver = NotificationObserver(notification: SfoNotification.Trip.invalidated) { validationSteps, _ in
      
      if let validationSteps = validationSteps {
        self.debugView().printDebugLine("Trip is invalid for reasons:", type: .Negative)
        for validationStep in validationSteps {
          self.debugView().printDebugLine("\(validationStep.description)", type: .Negative)
        }
      } else {
        self.debugView().printDebugLine("Trip is invalid", type: .Negative)
      }
    }
    
    sfoObservers.warningObserver = NotificationObserver(notification: SfoNotification.Trip.warning) { warning, _ in
      self.debugView().printDebugLine("Trip Warning: \(warning.rawValue)")
    }
  }
  
  func generateTripId() {
    TripStarted.sharedInstance.fire(123)
  }
}
