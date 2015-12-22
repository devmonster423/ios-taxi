//
//  IntlPickupGeofenceSpec.swift
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

class IntlPickupGeofenceSpec: QuickSpec {
  
  override func spec() {
    
    describe("the international pickup geofence") {
      
      it("can parse") {
        expect(LocalGeofence("International_Pax_Pickup")).toNot(beNil())
      }
    }
  }
}

