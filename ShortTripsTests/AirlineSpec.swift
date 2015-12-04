//
//  AirlineSpec.swift
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

class AirlineSpec: QuickSpec {
  var airline: Airline!
  
  override func spec() {
    describe("the Airline") {
      beforeEach {
        self.airline = Mapper<Airline>().map(MockAirlineString)
      }
      
      it("is non-nil") {
        expect(self.airline).toNot(beNil())
      }
      
      it("has an airlineName") {
        expect(self.airline.airlineName).toNot(beNil())
      }
      
      it("has an airlineCode") {
        expect(self.airline.airlineCode).toNot(beNil())
      }
    }
  }
}
