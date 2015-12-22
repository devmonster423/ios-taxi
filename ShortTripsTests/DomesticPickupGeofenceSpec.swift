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
        expect(domesticPickupGeofence.sfoGeofence) == SfoGeofence.SfoTaxiDomesticExit
      }
      
      it("denotes a bad point as being outside the geofence") {
        
        let badPoint = CLLocationCoordinate2D(latitude: 37.615091, longitude: -122.390150)
        
        expect(GeofenceArbiter.checkLocation(badPoint, againstFeatures: domesticPickupGeofence.features)).to(beFalse())
      }
      
      it("denotes a good point as being inside the geofence") {
        
        let goodPoint = CLLocationCoordinate2D(latitude: 37.614938, longitude: -122.386390)
        
        expect(GeofenceArbiter.checkLocation(goodPoint, againstFeatures: domesticPickupGeofence.features)).to(beTrue())
      }
    }
  }
}
