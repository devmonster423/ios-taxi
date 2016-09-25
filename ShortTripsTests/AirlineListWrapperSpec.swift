//
//  AirlineListWrapperSpec.swift
//  ShortTrips
//
//  Created by Pierre 🇫🇷 on 10/29/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

class AirlineListWrapperSpec: QuickSpec {
  var airlineListWrapper: AirlineListWrapper!
  
  override func spec() {
    describe("the AirlineList") {
      beforeEach {
        self.airlineListWrapper = Mapper<AirlineListWrapper>().map(JSONString: MockAirlineListResponseString)
      }
      
      it("is non-nil") {
        expect(self.airlineListWrapper).toNot(beNil())
      }
      
      it("has airlines") {
        expect (self.airlineListWrapper.airlines.count) > 1
      }
    }
  }
}
