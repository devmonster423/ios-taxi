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
    
    describe("the geofence") {
      it("denotes a bad point as being outside the geofence") {
        
        let badPoint = CLLocationCoordinate2D(latitude: 42.00, longitude: -110.00)
        
        expect(GeofenceArbiter.location(badPoint, isInsideRegion: ShortTripGeofence)).to(beFalse())
      }
      
      it("denotes a good point as being inside the geofence") {
        
        let goodPoint = CLLocationCoordinate2D(latitude: 38.00, longitude: -105.00)
        
        expect(GeofenceArbiter.location(goodPoint, isInsideRegion: ShortTripGeofence)).to(beTrue())
      }
    }
  }
}
