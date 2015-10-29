//
//  TripIdSwift.swift
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

class TripIdSpec: QuickSpec {
  var tripId: TripId!
  var map: Map!
  
  override func spec() {
    describe("the TripId") {
      beforeEach {
        self.tripId = TripId(tripId: 42)
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
      }
      
      it("is non-nil") {
        expect(self.tripId).toNot(beNil())
      }
      
      it("can map") {
        self.tripId.mapping(self.map)
      }
    }
  }
}