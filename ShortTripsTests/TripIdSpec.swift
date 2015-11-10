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
  
  override func spec() {
    describe("the TripId") {
      beforeEach {
        self.tripId = Mapper<TripId>().map(MockTripIdString)
      }
      
      it("is non-nil") {
        expect(self.tripId).toNot(beNil())
      }
      
      it("has a tripId") {
        expect(self.tripId).toNot(beNil())
      }
    }
  }
}
