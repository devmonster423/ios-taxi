//
//  EntryGateGeofenceSpec.swift
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

class EntryGateGeofenceSpec: QuickSpec {

  override func spec() {
    
    describe("the entry gate geofence") {
      
      it("can parse") {
        expect(entryGateGeofence).toNot(beNil())
      }
      
      it("denotes a bad point as being outside the geofence") {
        
        let badPoint = CLLocationCoordinate2D(latitude: 37.610560, longitude: -122.393328)
        
        expect(GeofenceArbiter.checkLocation(badPoint, againstFeatures: entryGateGeofence.features)).to(beFalse())
      }
      
      it("denotes a good point as being inside the geofence") {
        
        let goodPoint = CLLocationCoordinate2D(latitude: 37.615699660000075, longitude: -122.3883)
        
        expect(GeofenceArbiter.checkLocation(goodPoint, againstFeatures: entryGateGeofence.features)).to(beTrue())
      }
    }
  }
}
