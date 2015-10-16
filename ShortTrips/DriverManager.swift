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
  
  static let sharedInstance = DriverManager()
  
  private init() { }
  
  func setCurrentDriver(driver: Driver) {
    currentDriver = driver

    // TODO: remove this fix when card id is included
    currentDriver?.cardId = 123
  }
  
  func getCurrentDriver() -> Driver? {
    return currentDriver
  }
}