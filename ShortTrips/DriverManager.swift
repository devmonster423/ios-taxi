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
    currentVehicle = vehicle
    
    if let driver = getCurrentDriver() {
      let driverAndVehicle = (driver: driver, vehicle: vehicle)
      DriverAndVehicleAssociated.sharedInstance.fire(driverAndVehicle)
    }
  }
  
  func getCurrentVehicle(forceRefresh: Bool = false, completion: VehicleClosure) {
    if let currentVehicle = currentVehicle where !forceRefresh {
      completion(currentVehicle)
    } else {
      if let driver = getCurrentDriver() {
        ApiClient.getVehicle(driver.cardId) { vehicle in
          
          self.currentVehicle = vehicle
          completion(vehicle)
        }
      } else {
        completion(nil)
      }
    }
  }
  
}
