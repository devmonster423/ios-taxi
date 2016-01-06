//
//  PingShortTrip.swift
//  ShortTrips
//
//  Created by Joshua Adams on 12/1/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

extension ShortTripVC {
  
  func setupPingObservers() {
    sfoObservers.invalidPingObserver = NotificationObserver(notification: SfoNotification.Ping.invalid) { _, _ in
      self.shortTripView().updateTitle(NSLocalizedString("Invalid trip", comment: "").uppercaseString)
      self.shortTripView().notify(NSLocalizedString("Trip Went Outside Short Trip Geofence", comment: ""))
      self.shortTripView().topImageView.image = Image.tripX.image()
      self.shortTripView().notificationImageView.image = Image.tripGeofence.image()
    }
  }
}
