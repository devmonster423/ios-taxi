//
//  TripIdResponseSpec.swift
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

class TripIdResponseSpec: QuickSpec {
  var tripIdResponse: TripIdResponse!
  var map: Map!
  
  override func spec() {
    describe("the TripIdResponse") {
      beforeEach {
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
        self.tripIdResponse = TripIdResponse(self.map)
      }
      
      it("is non-nil") {
        expect(self.tripIdResponse).toNot(beNil())
      }
      
      it("can map") {
        self.tripIdResponse.mapping(self.map)
      }
    }
  }
}

