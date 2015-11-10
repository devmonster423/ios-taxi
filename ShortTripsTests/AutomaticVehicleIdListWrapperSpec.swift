//
//  AutomaticVehicleIdListWrapperSpec.swift
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

class AutomaticVehicleIdListWrapperSpec: QuickSpec {
  var automaticVehicleIdListWrapper: AutomaticVehicleIdListWrapper!
  
  override func spec() {
    describe("the AutomaticVehicleIdListWrapper") {
      beforeEach {
        self.automaticVehicleIdListWrapper = Mapper<AutomaticVehicleIdListWrapper>().map(MockAutomaticVehicleIdListWrapperString)
      }
      
      it("is non-nil") {
        expect(self.automaticVehicleIdListWrapper).toNot(beNil())
      }
      
      it("has at least one AutomaticVehicleId") {
        expect (self.automaticVehicleIdListWrapper.automaticVehicleIds.count) >= 1
      }
    }
  }
}

