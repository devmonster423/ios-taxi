//
//  DriverManagerSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/16/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble

class DriverManagerSpec: QuickSpec {
  
  override func spec() {
    
    describe("the driver manager") {
      
      it("can save and load a driver") {
        
        let driver = Driver(sessionId: 1,
          driverId: 2,
          cardId: 3,
          firstName: "Test",
          lastName: "Test",
          driverLicense: "3F0-3xy6y")
        
        DriverManager.sharedInstance.setCurrentDriver(driver)
        
        expect(DriverManager.sharedInstance.getCurrentDriver()!.driverId).to(equal(driver.driverId))
      }
      
      it("can save and load a vehicle") {
        
        let vehicle = Vehicle(vehicleId: 1, transponderId: "123")
        
        DriverManager.sharedInstance.setCurrentVehicle(vehicle)
        
        DriverManager.sharedInstance.getCurrentVehicle() { vehicle in
          if let vehicle = vehicle {
            expect(vehicle.vehicleId).to(equal(vehicle.vehicleId))
          }
        }
      }
    }
  }
}
