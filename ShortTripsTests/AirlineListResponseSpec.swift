//
//  AirlineResponseSpec.swift
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

class AirlineListResponseSpec: QuickSpec {
  var airlineListWrapper: AirlineListWrapper!
  var airlineListResponse: AirlineListResponse!
  var airlines: [Airline]!
  var map: Map!
  
  override func spec() {
    describe("the AirlineListResponse") {
      beforeEach {
        self.airlines = [Airline(airlineCode: "UA", airlineName: "United Airlines")]
        self.airlineListWrapper = AirlineListWrapper(airlines: self.airlines)
        self.airlineListResponse = AirlineListResponse(airlineListWrapper: self.airlineListWrapper)
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
      }
      
      it("is non-nil") {
        expect(self.airlineListResponse).toNot(beNil())
      }
      
      it("has an airline list") {
        expect(self.airlines).toNot(beNil())
      }
      
      it("can map") {
        expect(self.airlineListResponse.mapping(self.map)).toNot(beNil())
      }
    }
  }
}
