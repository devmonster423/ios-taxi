//
//  TripShortTrip.swift
//  ShortTrips
//
//  Created by Joshua Adams on 12/1/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

extension ShortTripVC {
  
  func setupTripObservers() {
    
    sfoObservers.reEntryAviFailedObserver = NotificationObserver(notification: SfoNotification.Trip.reEntryAviFailed) { _, _ in
      self.shortTripView().notificationLabel.text = "Optional Inbound Step Failed, Moving On..."
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    }
    
    sfoObservers.timeExpiredObserver = NotificationObserver(notification: SfoNotification.Trip.timeExpired) { _, _ in
      self.shortTripView().notificationLabel.text = "Time Expired"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    }
    
    sfoObservers.tripStartedObserver = NotificationObserver(notification: SfoNotification.Trip.started) { tripId, _ in
      self.shortTripView().notificationLabel.text = "Trip Started: \(tripId)"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    }
    
    sfoObservers.validatedObserver = NotificationObserver(notification: SfoNotification.Trip.validated) { _, _ in
      self.shortTripView().notificationLabel.text = "Trip is valid"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    }
    
    sfoObservers.invalidatedObserver = NotificationObserver(notification: SfoNotification.Trip.invalidated) { validationSteps, _ in
      if let validationSteps = validationSteps {
        var message = "Trip Is Invalid for Reasons: "
        for validationStep in validationSteps {
          message += validationStep.description + " "
        }
        self.shortTripView().notificationLabel.text = message
      } else {
        self.shortTripView().notificationLabel.text = "Trip Is Invalid"
      }
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    }
    
    sfoObservers.warningObserver = NotificationObserver(notification: SfoNotification.Trip.warning) { warning, _ in
      self.shortTripView().notificationLabel.text = "Trip Warning: \(warning.rawValue)"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    }
  }
}