//
//  GeofenceListWrapperSpec.swift
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

class GeofenceListWrapperSpec: QuickSpec {
  var geofenceList: [Geofence]!
  var geofenceListWrapper: GeofenceListWrapper!
  var map: Map!
  
  override func spec() {
    describe("the GeofenceListWrapper") {
      beforeEach {
        self.geofenceList = [Geofence(category: .City, description: "short-trip region", geofenceId: 42, name: "Snoopy")]
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
        self.geofenceListWrapper = GeofenceListWrapper(self.map)
        self.geofenceListWrapper.geofenceList = self.geofenceList
      }
      
      it("is non-nil") {
        expect(self.geofenceListWrapper).toNot(beNil())
      }
      
      it("has a Geofence list") {
        expect(self.geofenceList).toNot(beNil())
      }
      
      it("can map") {
        expect(self.geofenceListWrapper.mapping(self.map)).toNot(beNil())
      }
    }
  }
}
