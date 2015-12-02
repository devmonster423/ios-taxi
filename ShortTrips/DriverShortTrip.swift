//
//  DriverShortTrip.swift
//  ShortTrips
//
//  Created by Joshua Adams on 12/1/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

extension ShortTripVC {
  
  func setupDriverObservers() {
    sfoObservers.driverAndVehicleAssociated = NotificationObserver(notification: SfoNotification.Driver.vehicleAssociated, handler: { data, _ in
      let vehicle = data.vehicle
      let driver = data.driver
      self.shortTripView().notificationLabel.text = "Driver \(driver.firstName) \(driver.lastName) Is Associated with Transponder: \(vehicle.transponderId)"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    })
  }
}
