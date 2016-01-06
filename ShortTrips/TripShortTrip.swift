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
      self.shortTripView().topImageView.image = Image.tripX.image()
      self.shortTripView().updateTitle(.Invalid)
      self.shortTripView().notify(NSLocalizedString("Time Expired", comment: ""))
      self.shortTripView().notificationImageView.image = Image.tripTime.image()
    }
    
    sfoObservers.validatedObserver = NotificationObserver(notification: SfoNotification.Trip.validated) { _, _ in
      self.shortTripView().updateTitle(.Valid)
      self.shortTripView().topImageView.image = Image.tripCheck.image()
      self.shortTripView().notificationImageView.image = Image.tripCar.image()
    }
    
    sfoObservers.invalidatedObserver = NotificationObserver(notification: SfoNotification.Trip.invalidated) { validationSteps, _ in
      if let validationSteps = validationSteps {
        var message = ""
        for validationStep in validationSteps {
          message += validationStep.description + " "
        }
        self.shortTripView().notify(message)
      }
      
      self.shortTripView().updateTitle(.Invalid)
      self.shortTripView().topImageView.image = Image.tripX.image()
      self.shortTripView().notificationImageView.image = Image.tripCarInProgress.image()
    }
  }
}
