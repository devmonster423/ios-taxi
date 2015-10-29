//
//  AirlineSpec.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/29/15.
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
    describe("the Airline") {
      beforeEach {
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["airlineCode": NSString(string: "EX123"), "airlineName": NSString(string: "ExygyAirline")])
        self.airline = Airline(self.map)
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
