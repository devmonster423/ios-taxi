//
//  DriverDebugger.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

extension DebugVC {
  
  func setupDriverObservers() {
    sfoObservers.driverAndVehicleAssociated = NotificationObserver(notification: SfoNotification.Driver.vehicleAssociated, handler: { data, _ in
      let vehicle = data.vehicle
      let driver = data.driver
      self.debugView().printDebugLine("driver \(driver.firstName) \(driver.lastName) is associated with transponder: \(vehicle.transponderId)")
      self.debugView().incrementGtms()
    })
  }
  
  func associateDriverAndVehicle() {
    let vehicle = Vehicle(gtmsTripId: 10590,
      licensePlate: "13702K1",
      medallion: "0737",
      transponderId: 2005887,
      vehicleId: 12999)
    DriverManager.sharedInstance.setCurrentVehicle(vehicle)
  }
}
