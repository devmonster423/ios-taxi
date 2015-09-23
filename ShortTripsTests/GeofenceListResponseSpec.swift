//
//  GeofenceListResponseSpec.swift
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

class GeofenceListResponseSpec: QuickSpec {
  var geofenceList: [Geofence]!
  var geofenceListResponse: GeofenceListResponse!
  var map: Map!

  override func spec() {
    describe("the GeofenceListResponse") {
      beforeEach {
        self.geofenceList = [Geofence(category: .City, description: "short-trip region", geofenceId: 42, name: "Snoopy")]
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
        self.geofenceListResponse = GeofenceListResponse(self.map)
        self.geofenceListResponse.geofenceList = self.geofenceList
      }

      it("is non-nil") {
        expect(self.geofenceListResponse).toNot(beNil())
      }

      it("has a Geofence list") {
        expect(self.geofenceList).toNot(beNil())
      }

      it("can map") {
        expect(self.geofenceListResponse.mapping(self.map)).toNot(beNil())
      }
    }
  }
}
