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
    
    sfoObservers.timeExpiredObserver = NotificationObserver(notification: SfoNotification.Trip.timeExpired) { _, _ in
      self.shortTripView().currentStateLabel.text = NSLocalizedString("Time Expired", comment: "")
      self.shortTripView().notify(NSLocalizedString("Time Expired", comment: ""))
      self.shortTripView().notificationImageView.image = Image.taxicross.image()
    }
    
    sfoObservers.validatedObserver = NotificationObserver(notification: SfoNotification.Trip.validated) { _, _ in
      self.shortTripView().currentStateLabel.text = NSLocalizedString("Trip is valid", comment: "")
      self.shortTripView().notify(NSLocalizedString("Trip is valid", comment: ""))
      self.shortTripView().notificationImageView.image = Image.taxicheckmark.image()
    }
    
    sfoObservers.invalidatedObserver = NotificationObserver(notification: SfoNotification.Trip.invalidated) { validationSteps, _ in
      if let validationSteps = validationSteps {
        var message = NSLocalizedString("Trip Is Invalid for Reasons", comment: "") + ": "
        for validationStep in validationSteps {
          message += validationStep.description + " "
        }
        self.shortTripView().notify(message)
      } else {
        self.shortTripView().notify(NSLocalizedString("Trip Is Invalid", comment: ""))
      }
      self.shortTripView().currentStateLabel.text = NSLocalizedString("Trip Is Invalid", comment: "")
      self.shortTripView().notificationImageView.image = Image.taxicross.image()
    }
  }
}
