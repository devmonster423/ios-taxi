//
//  TripValidation.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/23/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

class TripValidationSpec: QuickSpec {
  var tripValidation: TripValidation!
  
  override func spec() {
    describe("the TripValidation") {
      beforeEach {
        self.tripValidation = Mapper<TripValidation>().map(MockTripValidationString)
      }
      
      it("is non-nil") {
        expect(self.tripValidation).toNot(beNil())
      }
      
      it("has a valid bool") {
        expect(self.tripValidation.valid).toNot(beNil())
      }
    }
  }
}

