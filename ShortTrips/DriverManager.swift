//
//  DriverManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/16/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

class DriverManager {
  
  fileprivate var currentDriver: Driver?
  fileprivate var currentVehicle: Vehicle?
  fileprivate var sessionCreationDate: Date?
  fileprivate let validSessionAge: TimeInterval = 24 * 60 * 60 * 1000
  
  static let sharedInstance = DriverManager()
  
  fileprivate init() { }
  
  func setCurrentDriver(_ driver: Driver?) {
    currentDriver = driver
    sessionCreationDate = driver != nil ? Date() : nil
  }
  
  func getCurrentDriver() -> Driver? {
    return currentDriver
  }
  
  func setCurrentVehicle(_ vehicle: Vehicle?) {
    currentVehicle = vehicle
    
    if let driver = getCurrentDriver(), let vehicle = vehicle {
      let driverAndVehicle = (driver: driver, vehicle: vehicle)
      DriverAndVehicleAssociated.sharedInstance.fire(driverAndVehicle)
    }
  }
  
  func getCurrentVehicle() -> Vehicle? {
    return currentVehicle
  }
  
  fileprivate func hasValidSession() -> Bool {
    if let sessionCreationDate = sessionCreationDate {
      return sessionCreationDate.timeIntervalSinceNow > -validSessionAge
    } else {
      return false
    }
  }
  
  func callWithValidSession(_ callback: @escaping () -> ()) {
    if hasValidSession() {
      callback()
      
    } else {
      
      guard let credential = DriverCredential.load() else {
        fatalError("can't call this when not logged in")
      }
      
      ApiClient.authenticateDriver(credential) { driver in
        if let driver = driver {
          credential.save()
          DriverManager.sharedInstance.setCurrentDriver(driver)
          callback()
        } else {
          self.callWithValidSession(callback)
        }
      }
    }
  }
}
