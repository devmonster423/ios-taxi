//
//  GeofenceShortTrip.swift
//  ShortTrips
//
//  Created by Joshua Adams on 12/1/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

extension ShortTripVC {
  
  func setupGeofenceObservers() {
    sfoObservers.outsideShortTripObserver = NotificationObserver(notification: SfoNotification.Geofence.outsideShortTrip) { _, _ in
      self.shortTripView().notify(NSLocalizedString("Trip Went Outside Short Trip Geofence", comment: ""))
      self.shortTripView().notificationImageView.image = Image.taxicross.image()
    }
  }
}
