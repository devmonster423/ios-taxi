//
//  AirlineListResponseSpec.swift
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

class AirlineListResponseSpec: QuickSpec {
  var airlineListResponse: AirlineListResponse!
  var map: Map!
  
  override func spec() {
    describe("the AirlineListResponse") {
      beforeEach {
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["response": ["airlines": ["airline" : NSString(string: "EX123"), "airlineName": NSString(string: "ExygyAirline")]]] )
        self.airlineListResponse = AirlineListResponse(self.map)
      }
      
      it("is non-nil") {
        expect(self.airlineListResponse).toNot(beNil())
      }
      
      it("can map") {
        expect(self.airlineListResponse.mapping(self.map)).toNot(beNil())
      }
    }
  }
}