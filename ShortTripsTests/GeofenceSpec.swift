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
  var map: Map!

  override func spec() {
    describe("the Geofence") {
      beforeEach {
        self.geofence = Geofence(category: .City, description: "short-trip region", geofenceId: 42, name: "Snoopy")
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
      }

      it("is non-nil") {
        expect(self.geofence).toNot(beNil())
      }

      it("can map") {
        expect(self.geofence.mapping(self.map)).toNot(beNil())
      }
    }
  }
}
