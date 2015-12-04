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
import ObjectMapper
import MapKit

class ShortTripGeofenceSpec: QuickSpec {
  
  var polygons: [MKPolygon]!

  override func spec() {
    
    describe("the entry gate geofence") {
      beforeEach {

        let localGeofence = Mapper<LocalGeofence>().map(EntryGateString)!
        let feature = localGeofence.features[0]
        self.polygons = feature.polygons()
      }

      it("denotes a bad point as being outside the geofence") {
        
        let badPoint = CLLocationCoordinate2D(latitude: 37.610560, longitude: -122.393328)
        
        expect(GeofenceArbiter.location(badPoint, isInsideRegion: self.polygons[0])).to(beFalse())
      }
      
      it("denotes a good point as being inside the geofence") {
        
        let goodPoint = CLLocationCoordinate2D(latitude: 37.615699660000075, longitude: -122.3883)
        
        expect(GeofenceArbiter.location(goodPoint, isInsideRegion: self.polygons[0])).to(beTrue())
      }
    }
  }
}
