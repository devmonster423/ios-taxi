//
//  FoundGeofenceStatusSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/23/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

class FoundGeofenceStatusSpec: QuickSpec {
  var foundGeofenceStatus1: FoundGeofenceStatus!
  var foundGeofenceStatus2: FoundGeofenceStatus!
  
  override func spec() {
    describe("the FoundGeofenceStatus") {
      beforeEach {
        self.foundGeofenceStatus1 = Mapper<FoundGeofenceStatus>().map(MockFoundGeofenceStatusString)
        self.foundGeofenceStatus2 = FoundGeofenceStatus(status: .Valid, geofence: .Sfo)
      }
      
      it("is non-nil") {
        expect(self.foundGeofenceStatus1).toNot(beNil())
        expect(self.foundGeofenceStatus2).toNot(beNil())
      }
    }
  }
}
