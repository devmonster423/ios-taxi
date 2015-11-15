//
//  GeofenceSpec.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/23/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

class GeofenceSpec: QuickSpec {
  var geofence: Geofence!

  override func spec() {
    describe("the Geofence") {
      beforeEach {
        self.geofence = Mapper<Geofence>().map(MockGeofenceString)
      }

      it("is non-nil") {
        expect(self.geofence).toNot(beNil())
      }

      it("is a valid Geofence") {
        expect(self.geofence.geofence).toNot(beNil())
        expect(self.geofence.name).toNot(beNil())
      }
    }
  }
}
