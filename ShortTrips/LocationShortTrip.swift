//
//  LocationShortTrip.swift
//  ShortTrips
//
//  Created by Joshua Adams on 12/1/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import CoreLocation
import JSQNotificationObserverKit

extension ShortTripVC {
  
  func setupLocationObservers() {
    sfoObservers.locationStatusObserver = NotificationObserver(notification: SfoNotification.Location.statusUpdated, handler: { status, _ in
      if status == .AuthorizedAlways {
        self.shortTripView().notificationLabel.text = "Location Status Updated: GPS On"
      } else {
        self.shortTripView().notificationLabel.text = "Location Status Updated: GPS Off"
        self.shortTripView().notificationImageView.image = Image.thumbsdown.image()
      }
    })
  }
}