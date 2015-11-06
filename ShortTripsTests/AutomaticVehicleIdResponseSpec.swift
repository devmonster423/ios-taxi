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
  var automaticVehicleIdListWrapper: AutomaticVehicleIdListWrapper!
  var map: Map!
  
  override func spec() {
    describe("the AutomaticVehicleIdResponse") {
      beforeEach {
        self.automaticVehicleIds = [AutomaticVehicleId(location: "parking lot", id: "42")]
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
        self.automaticVehicleIdListWrapper = AutomaticVehicleIdListWrapper(self.map)
        self.automaticVehicleIdListWrapper.automaticVehicleIds = self.automaticVehicleIds
      }
      
      it("is non-nil") {
        expect(self.automaticVehicleIdListWrapper).toNot(beNil())
      }
      
      it("has AutomaticVehicleIds") {
        expect(self.automaticVehicleIds).toNot(beNil())
      }
      
      it("can map") {
        expect(self.automaticVehicleIdListWrapper.mapping(self.map)).toNot(beNil())
      }
    }
  }
}

