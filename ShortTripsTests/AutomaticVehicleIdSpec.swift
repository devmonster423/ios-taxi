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
  
  override func spec() {
    describe("the AutomaticVehicleId") {
      beforeEach {
        self.automaticVehicleId = Mapper<AutomaticVehicleId>().map(MockAutomaticVehicleIdString)
      }
      
      it("is non-nil") {
        expect(self.automaticVehicleId).toNot(beNil())
      }
      
      it("is a valid AutomaticVehicleId") {
        expect(self.automaticVehicleId.location).toNot(beNil())
        expect(self.automaticVehicleId.id).toNot(beNil())
      }

    }
  }
}

