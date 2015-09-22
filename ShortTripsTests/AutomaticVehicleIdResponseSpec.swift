//
//  AutomaticVehicleIdResponseSpec.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/22/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

class AutomaticVehicleIdResponseSpec: QuickSpec {
  var automaticVehicleIds: [AutomaticVehicleId]!
  var automaticVehicleIdResponse: AutomaticVehicleIdResponse!
  var map: Map!
  
  override func spec() {
    describe("the AutomaticVehicleIdResponse") {
      beforeEach {
        self.automaticVehicleIds = [AutomaticVehicleId(location: "parking lot", id: "42")]
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
        self.automaticVehicleIdResponse = AutomaticVehicleIdResponse(self.map)
        self.automaticVehicleIdResponse.automaticVehicleIds = self.automaticVehicleIds
      }
      
      it("is non-nil") {
        expect(self.automaticVehicleIdResponse).toNot(beNil())
      }
      
      it("has AutomaticVehicleIds") {
        expect(self.automaticVehicleIds).toNot(beNil())
      }
      
      it("can map") {
        self.automaticVehicleIdResponse.mapping(self.map)
      }
    }
  }
}

