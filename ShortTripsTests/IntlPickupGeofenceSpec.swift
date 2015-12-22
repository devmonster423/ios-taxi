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
        expect(intlPickupGeofence).toNot(beNil())
        expect(intlPickupGeofence.sfoGeofence) == SfoGeofence.SfoInternationalExit
      }
      
      it("denotes a bad point as being outside the geofence") {
        
        let badPoint = CLLocationCoordinate2D(latitude: 37.615256, longitude: -122.393191)
        
        expect(GeofenceArbiter.checkLocation(badPoint, againstFeatures: intlPickupGeofence.features)).to(beFalse())
      }
      
      it("denotes a good point as being inside the geofence") {
        
        let goodPoint = CLLocationCoordinate2D(latitude: 37.615305, longitude: -122.390220)
        
        expect(GeofenceArbiter.checkLocation(goodPoint, againstFeatures: intlPickupGeofence.features)).to(beTrue())
      }
    }
  }
}

