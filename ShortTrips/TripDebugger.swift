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

    entryStepFailedObserver = NotificationObserver(notification: SfoNotification.Trip.entryStepFailed) { _, _ in
      self.debugView().printDebugLine("Optional entry step failed, moving on...", type: .Negative)
    }
    
    inboundStepFailedObserver = NotificationObserver(notification: SfoNotification.Trip.inboundStepFailed) { _, _ in
      self.debugView().printDebugLine("optional inbound step failed, moving on...", type: .Negative)
    }

    timeExpiredObserver = NotificationObserver(notification: SfoNotification.Trip.timeExpired) { _, _ in
      self.debugView().printDebugLine("Time Expired")
    }
    
    tripStartedObserver = NotificationObserver(notification: SfoNotification.Trip.started) { tripId, _ in
      self.debugView().printDebugLine("Trip started: \(tripId)", type: .Positive)
    }
    
    validatedObserver = NotificationObserver(notification: SfoNotification.Trip.validated) { _, _ in
      self.debugView().printDebugLine("Trip is valid", type: .Positive)
    }
    
    invalidatedObserver = NotificationObserver(notification: SfoNotification.Trip.invalidated) { validationSteps, _ in
      
      if let validationSteps = validationSteps {
        self.debugView().printDebugLine("Trip is invalid for reasons:", type: .Negative)
        for validationStep in validationSteps {
          self.debugView().printDebugLine("\(validationStep.description)", type: .Negative)
        }
      } else {
        self.debugView().printDebugLine("Trip is invalid", type: .Negative)
      }
    }
    
    warningObserver = NotificationObserver(notification: SfoNotification.Trip.warning) { warning, _ in
      self.debugView().printDebugLine("Trip Warning: \(warning.rawValue)")
    }
  }
  
  func generateTripId() {
    TripStarted.sharedInstance.fire(123)
  }
}
