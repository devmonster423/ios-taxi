//
//  VehicleResponse.swift
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

class VehicleResponseSpec: QuickSpec {
  var vehicle: Vehicle!
  var vehicleResponse: VehicleResponse!
  var map: Map!
  
  override func spec() {
    describe("the VehicleResponse") {
      beforeEach {
        self.vehicle = Vehicle(vehicleId: 42, transponderId: "🐴")
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
        self.vehicleResponse = VehicleResponse(self.map)
        self.vehicleResponse.vehicle = self.vehicle
      }
      
      it("is non-nil") {
        expect(self.vehicleResponse).toNot(beNil())
      }
      
      it("has a Driver") {
        expect(self.vehicle).toNot(beNil())
      }
      
      it("can map") {
        self.vehicleResponse.mapping(self.map)
      }
    }
  }
}
