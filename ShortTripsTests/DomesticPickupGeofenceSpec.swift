//
//  DomesticPickupGeofenceSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/22/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import CoreLocation

class DomesticPickupGeofenceSpec: QuickSpec {

  override func spec() {
    describe("the domestic pickup geofence") {
      
      it("can parse") {
        expect(domesticPickupGeofence).toNot(beNil())
      }
    }
  }
}
