//
//  GeofenceResponseSpec.swift
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

class GeofenceResponseSpec: QuickSpec {
  var geofence: Geofence!
  var geofenceResponse: GeofenceResponse!
  var map: Map!

  override func spec() {
    describe("the GeofenceResponse") {
      beforeEach {
        self.geofence = Geofence(category: .City, description: "short-trip region", geofenceId: 42, name: "Snoopy")
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
        self.geofenceResponse = GeofenceResponse(self.map)
        self.geofenceResponse.geofence = self.geofence
      }

      it("is non-nil") {
        expect(self.geofenceResponse).toNot(beNil())
      }

      it("has a Geofence") {
        expect(self.geofence).toNot(beNil())
      }

      it("can map") {
        expect(self.geofenceResponse.mapping(self.map)).toNot(beNil())
      }
    }
  }
}
