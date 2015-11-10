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
  var vehicle: Vehicle!
  
  override func spec() {
    describe("the Vehicle") {
      beforeEach {
        self.vehicle = Mapper<Vehicle>().map(MockVehicleString)
      }
      
      it("is non-nil") {
        expect(self.vehicle).toNot(beNil())
      }
      
      it("is a valid Vehicle") {
        expect(self.vehicle.vehicleId).toNot(beNil())
        expect(self.vehicle.transponderId).toNot(beNil())
      }
    }
  }
}
