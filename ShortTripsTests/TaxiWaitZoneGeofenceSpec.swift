//
//  LocalGeofenceSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/11/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import CoreLocation

class TaxiWaitZoneGeofenceSpec: QuickSpec {
  
  override func spec() {
    describe("the taxi wait zone geofence") {
      
      it("can parse") {
        expect(LocalGeofence("Taxi_Waiting_Zone")).toNot(beNil())
      }
    }
  }
}
