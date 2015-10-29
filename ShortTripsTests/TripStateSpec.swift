//
//  TripStateSpec.swift
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

class TripIdSateSpec: QuickSpec {
  
  override func spec() {
    describe("the TripIdState") {
      it("is non-nil") {
        expect(TripState.Short).toNot(beNil())
        expect(TripState.Long).toNot(beNil())
      }
      
    }
  }
}

