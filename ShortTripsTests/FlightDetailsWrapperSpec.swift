//
//  FlightDetailsWrapperSpec.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

class FlightDetailResponseSpec: QuickSpec {
  var flightDetailsWrapper: FlightDetailsWrapper!
  var flightDetails: [Flight]!
  
  override func spec() {
    describe("the FlightDetailsWrapper") {
      beforeEach {
        self.flightDetailsWrapper = Mapper<FlightDetailsWrapper>().map(JSONString: MockFlightDetailsWrapperString)
      }
      
      it("is non-nil") {
        expect(self.flightDetailsWrapper).toNot(beNil())
      }
      
      it("has a flightDetails") {
        expect(self.flightDetailsWrapper.flightDetails).toNot(beNil())
      }
      
      it("has a Flight") {
        expect(self.flightDetailsWrapper.flightDetails[0]).toNot(beNil())
      }
    }
  }
}

