//
//  VehicleSpec.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/29/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

class VehicleSpec: QuickSpec {
  var vehicle1: Vehicle!
  var vehicle2: Vehicle!
  
  override func spec() {
    describe("the Vehicle") {
      beforeEach {
        self.vehicle1 = Mapper<Vehicle>().map(JSONString: MockVehicleString1)
        self.vehicle2 = Mapper<Vehicle>().map(JSONString: MockVehicleString2)
      }
      
      it("is non-nil") {
        expect(self.vehicle1).toNot(beNil())
        expect(self.vehicle2).toNot(beNil())
      }
      
      it("is a valid Vehicle") {
        expect(self.vehicle1.vehicleId).toNot(beNil())
        expect(self.vehicle1.transponderId).toNot(beNil())
        expect(self.vehicle1.gtmsTripId).toNot(beNil())
        expect(self.vehicle1.licensePlate).toNot(beNil())
        expect(self.vehicle1.medallion).toNot(beNil())
        
        expect(self.vehicle2.vehicleId).toNot(beNil())
        expect(self.vehicle2.transponderId).toNot(beNil())
        expect(self.vehicle2.gtmsTripId).toNot(beNil())
        expect(self.vehicle2.licensePlate).toNot(beNil())
        expect(self.vehicle2.medallion).toNot(beNil())
      }
    }
  }
}
