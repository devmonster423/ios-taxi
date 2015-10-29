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
import Mockingjay

class DriverClientSpec: QuickSpec {
  
  override func spec() {
    
    describe("the driver client") {
      
      it("can login") {
        self.stub(uri(Url.Driver.login), builder: json(DriverLoginMock))

        let credential = DriverCredential(username: "🐅", password: "🐃");
        ApiClient.authenticateDriver(credential) { response, error in
          expect(response).toNot(beNil())
        }
      }
      
      it("can request driver vehicle") {
        let driverId = 1;
        self.stub(uri(Url.Driver.vehicle(driverId)), builder: json(DriverVehicleMock))
        ApiClient.getVehicle(driverId) { vehicle in
          expect(vehicle).toNot(beNil())
        }
      }
      
    }
  }
}