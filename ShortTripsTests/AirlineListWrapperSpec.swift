//
//  AirlineListWrapperSpec.swift
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

class AirlineListWrapperSpec: QuickSpec {
  var airlineList: [Airline]!
  var airlineListWrapper: AirlineListWrapper!
  var map: Map!
  
  override func spec() {
    describe("the AirlineListWrapper") {
      beforeEach {
        self.airlineList = [Airline(airlineCode: "UA", airlineName: "United Airlines")]
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
        self.airlineListWrapper = AirlineListWrapper(self.map)
        self.airlineListWrapper.airlines = self.airlineList
      }
      
      it("is non-nil") {
        expect(self.airlineListWrapper).toNot(beNil())
      }
      
      it("has an airline list") {
        expect(self.airlineList).toNot(beNil())
      }
      
      it("can map") {
        expect(self.airlineListWrapper.mapping(self.map)).toNot(beNil())
      }
    }
  }
}
