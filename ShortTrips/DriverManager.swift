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
  private var sessionCreationDate: NSDate?
  private let validSessionAge: NSTimeInterval = 24 * 60 * 60 * 1000
  
  static let sharedInstance = DriverManager()
  
  private init() { }
  
  func setCurrentDriver(driver: Driver) {
    currentDriver = driver
    sessionCreationDate = NSDate()
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
  
  func getCurrentVehicle() -> Vehicle? {
    return currentVehicle
  }
  
  private func hasValidSession() -> Bool {
    if let sessionCreationDate = sessionCreationDate {
      return sessionCreationDate.timeIntervalSinceNow > -validSessionAge
    } else {
      return false
    }
  }
  
  func callWithValidSession(callback: () -> ()) {
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
