//
//  AutomaticVehicleIdSpec.swift
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

class AutomaticVehicleIdSpec: QuickSpec {
  var automaticVehicleId: AutomaticVehicleId!
  var map: Map!
  
  override func spec() {
    describe("the AutomaticVehicleId") {
      beforeEach {
        self.automaticVehicleId = AutomaticVehicleId(location: "parking lot", id: "42")
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
      }
      
      it("is non-nil") {
        expect(self.automaticVehicleId).toNot(beNil())
      }
      
      it("can map") {
        expect(self.automaticVehicleId.mapping(self.map)).toNot(beNil())
      }
    }
  }
}

