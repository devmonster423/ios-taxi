//
//  MobileStateChangeSpec.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/29/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import CoreLocation
import Quick
import Nimble
import Foundation
import ObjectMapper

class MobileStateChangeSpec: QuickSpec {
  var mobileStateChange: MobileStateChange!
  var map: Map!
  
  override func spec() {
    describe("the Ping") {
      beforeEach {
        self.mobileStateChange = MobileStateChange(longitude: 37.615716, latitude: -122.388321, tripId: 41, tripState: TripState.Long, mobileState: MobileState.NotReady, sessionId: 1)
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
      }
      
      it("is non-nil") {
        expect(self.mobileStateChange).toNot(beNil())
      }

      it("has Mobile State") {
        expect(MobileState.NotReady).toNot(beNil())
      }
      
      it("can map") {
        self.mobileStateChange.mapping(self.map)
      }
    }
  }
}