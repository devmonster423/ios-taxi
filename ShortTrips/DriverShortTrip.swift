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
    sfoObservers.driverAndVehicleAssociated = NotificationObserver(notification: SfoNotification.Driver.vehicleAssociated) { data, _ in
      let vehicle = data.vehicle
      let driver = data.driver
      self.shortTripView().notify(String(format: NSLocalizedString("Driver Is Associated with Transponder", comment: ""), arguments: [driver.firstName, driver.lastName, vehicle.transponderId]))
    }
  }
}
