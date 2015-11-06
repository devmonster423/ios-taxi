//
//  AirlineListSpec.swift
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

class AirlineListSpec: QuickSpec {
  var airlineList: AirlineList!
  var map: Map!
  
  override func spec() {
    describe("the AirlineList") {
      beforeEach {
        self.airlineList = Mapper<AirlineList>().map(MockAirlineListResponseString)
      }
      
      it("is non-nil") {
        expect(self.airlineList).toNot(beNil())
      }
      
      it("has airlines") {
        expect (self.airlineList.airlines.count) > 1
      }
    }
  }
}