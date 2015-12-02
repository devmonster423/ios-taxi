//
//  RequestShortTrip.swift
//  ShortTrips
//
//  Created by Joshua Adams on 12/1/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

extension ShortTripVC {
  
  func setupRequestObservers() {
    sfoObservers.responseObserver = NotificationObserver(notification: SfoNotification.Request.response, handler: { response, _ in
      self.shortTripView().notificationLabel.text = "URL: \(response.URL!)\n statusCode: \(response.statusCode)"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    })
  }
}
