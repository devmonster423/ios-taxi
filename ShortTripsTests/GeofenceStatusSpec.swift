//
//  GeofenceStatusSpec.swift
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

class GeofenceStatus: QuickSpec {
  var geofenceStatus: GeofenceStatus!
  var map: Map!
  
  override func spec() {
    describe("the GeofenceStatus") {
      beforeEach {
        self.geofenceStatus = GeofenceStatus()
      }
      
      it("is non-nil") {
        expect(self.geofenceStatus).toNot(beNil())
      }
    }
  }
}