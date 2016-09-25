//
//  DriveClientSpec.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/28/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble

class DriverClientSpec: QuickSpec {
  
  override func spec() {
    
    describe("the driver client") {
      
      beforeEach {
        if !Url.isDevUrl() {
          fatalError("can't call this when not logged in")
        }
      }
      
      xit("can login") {
//        self.stub(uri(Url.Driver.login), builder: json(DriverLoginMock))

        let credential = DriverCredential(username: "🐅", password: "🐃");
        ApiClient.authenticateDriver(credential) { driver in
          expect(driver).toNot(beNil())
        }
      }
      
      xit("can request driver vehicle") {
        let driverId = "1"
//        self.stub(uri(Url.Driver.vehicle(driverId)), builder: json(DriverVehicleMock))
        ApiClient.getVehicle(driverId) { vehicle in
          expect(vehicle).toNot(beNil())
        }
      }
      
    }
  }
}
