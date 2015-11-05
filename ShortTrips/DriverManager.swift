//
//  DriverManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/16/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

class DriverManager {
  
  private var currentDriver: Driver?
  private var currentVehicle: Vehicle?
  
  static let sharedInstance = DriverManager()
  
  private init() { }
  
  func setCurrentDriver(driver: Driver) {
    currentDriver = driver
  }
  
  func getCurrentDriver() -> Driver? {
    return currentDriver
  }
  
  func setCurrentVehicle(vehicle: Vehicle) {
    var vehicle = vehicle    
    vehicle.transponderId = "3F0-3xy6y"
    
    currentVehicle = vehicle
    
    if let driver = getCurrentDriver() {
      let driverAndVehicle = (driver: driver, vehicle: vehicle)
      DriverAndVehicleAssociated.sharedInstance.fire(driverAndVehicle)
    }
  }
  
  func getCurrentVehicle() -> Vehicle? {
    return currentVehicle
  }
}