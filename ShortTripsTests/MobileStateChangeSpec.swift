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

class MobileStateInfoSpec: QuickSpec {
  var mobileStateInfo: MobileStateInfo!
  
  override func spec() {
    describe("the Ping") {
      beforeEach {
        self.mobileStateInfo = MobileStateInfo(longitude: 37.615716, latitude: -122.388321, sessionId: 1, tripId: 41)
      }
      
      it("is non-nil") {
        expect(self.mobileStateInfo).toNot(beNil())
      }
      
      it("can map") {
        expect(self.mobileStateInfo.toJSON()).toNot(beNil())
      }
    }
  }
}
