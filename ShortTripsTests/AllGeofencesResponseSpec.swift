//
//  AllGeofencesResponseSpec.swift
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

class AllGeofencesResponseSpec: QuickSpec {
  var geofenceListResponse: GeofenceListResponse!
  var allGeofencesResponse: AllGeofencesResponse!
  var allGeofences: [Geofence]!
  var map: Map!

  override func spec() {
    describe("the AllGeofencesResponse") {
      beforeEach {
        self.allGeofences = [Geofence(category: .City, description: "short-trip region", geofenceId: 42, name: "Snoopy")]
        self.geofenceListResponse = GeofenceListResponse(geofenceList: self.allGeofences)
        self.allGeofencesResponse = AllGeofencesResponse(geofenceListResponse: self.geofenceListResponse)
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
      }

      it("is non-nil") {
        expect(self.allGeofencesResponse).toNot(beNil())
      }

      it("has a Geofence list response") {
        expect(self.geofenceListResponse).toNot(beNil())
      }

      it("can map") {
        expect(self.allGeofencesResponse.mapping(self.map)).toNot(beNil())
      }
    }
  }
}
