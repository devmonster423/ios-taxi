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
  var geofenceListWrapper: GeofenceListWrapper!
  
  override func spec() {
    describe("the GeofenceListWrapper") {
      beforeEach {
        self.geofenceListWrapper = Mapper<GeofenceListWrapper>().map(JSONString: MockGeofenceListWrapperString)
      }
      
      it("is non-nil") {
        expect(self.geofenceListWrapper).toNot(beNil())
      }
      
      it("has a Geofence list") {
        expect(self.geofenceListWrapper.geofenceList).toNot(beNil())
      }
      
      it("has a valid Geofence") {
        expect(self.geofenceListWrapper.geofenceList[0].geofence).toNot(beNil())
        expect(self.geofenceListWrapper.geofenceList[0].name).toNot(beNil())
      }
    }
  }
}
