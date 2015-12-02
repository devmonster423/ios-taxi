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
    sfoObservers.locationManagerStartedObserver = NotificationObserver(notification: SfoNotification.Location.managerStarted) { _, _ in
      self.shortTripView().notificationLabel.text = "Started Location Manager"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    }
    
    sfoObservers.locationObserver = NotificationObserver(notification: SfoNotification.Location.read, handler: { location, _ in
      self.shortTripView().notificationLabel.text = "Read Location: (\(location.coordinate.latitude), \(location.coordinate.longitude)) at \(location.timestamp)"
      self.shortTripView().notificationImageView.image = UIImage(named: "notInGeofence.png")
    })
    
    sfoObservers.locationStatusObserver = NotificationObserver(notification: SfoNotification.Location.statusUpdated, handler: { status, _ in
      if status == .AuthorizedAlways {
        self.shortTripView().notificationLabel.text = "Location Status Updated: GPS On"
        self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
      } else {
        self.shortTripView().notificationLabel.text = "Location Status Updated: GPS Off"
        self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
      }
    })
  }
}