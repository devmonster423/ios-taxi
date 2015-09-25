//
//  AirlineSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/25/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

class AirlineSpec: QuickSpec {
  var airline: Airline!
  var map: Map!
  
  override func spec() {
    describe("the airline") {
      beforeEach {
        self.airline = Airline(airlineCode: "UA", airlineName: "United Airlines")
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
      }
      
      it("is non-nil") {
        expect(self.airline).toNot(beNil())
      }
      
      it("can map") {
        expect(self.airline.mapping(self.map)).toNot(beNil())
      }
    }
  }
}
