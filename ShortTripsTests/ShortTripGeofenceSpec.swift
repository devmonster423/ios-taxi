//
//  ShortTripGeofenceSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import CoreLocation

class ShortTripGeofenceSpec: QuickSpec {
  
  override func spec() {
    
    describe("the entry gate geofence") {
      it("denotes a bad point as being outside the geofence") {
        
        let badPoint = CLLocationCoordinate2D(latitude: 37.610560, longitude: -122.393328)
        
        expect(GeofenceArbiter.location(badPoint, isInsideRegion: EntryGateGeofences[0])).to(beFalse())
      }
      
      it("denotes a good point as being inside the geofence") {
        
        let goodPoint = CLLocationCoordinate2D(latitude: 37.615699660000075, longitude: -122.3883)
        
        expect(GeofenceArbiter.location(goodPoint, isInsideRegion: EntryGateGeofences[0])).to(beTrue())
      }
    }
  }
}
