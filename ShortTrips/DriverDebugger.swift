//
//  DriverDebugger.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

protocol DriverDebugger { }

extension DriverDebugger where Self: DebugVC {
  
  func setupDriverObservers() {
    driverAndVehicleAssociated = NotificationObserver(notification: SfoNotification.Driver.vehicleAssociated, handler: { data, _ in
      let vehicle = data.vehicle
      let driver = data.driver
      
      self.debugView().printDebugLine("driver \(driver.firstName) \(driver.lastName) is associated with transponder: (\(vehicle.transponderId)")
      self.updateFakeButton("Confirm Entry Gate Avi Read", action: "confirmEntryGateAviRead")
    })
  }
  
  func associateDriverAndVehicle() {
    let vehicle = Vehicle(vehicleId: 123, transponderId: "what")
    DriverManager.sharedInstance.setCurrentVehicle(vehicle)
  }
}
