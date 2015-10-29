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
  var map: Map!
  
  override func spec() {
    describe("the Vehicle") {
      beforeEach {
        self.vehicle = Vehicle(vehicleId: 42, transponderId: "df")
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
      }
      
      it("is non-nil") {
        expect(self.vehicle).toNot(beNil())
      }
      
      it("can map") {
        self.vehicle.mapping(self.map)
      }
    }
  }
}
