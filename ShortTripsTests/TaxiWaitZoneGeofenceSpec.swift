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
        expect(taxiWaitingZone).toNot(beNil())
        expect(taxiWaitingZone.sfoGeofence) == SfoGeofence.taxiWaitingZone
      }
      
      it("denotes a bad point as being outside the geofence") {
        
        let badPoint = CLLocationCoordinate2D(latitude:  37.614938, longitude: -122.386390)
        
        expect(GeofenceArbiter.checkLocation(badPoint, againstFeatures: taxiWaitingZone.features)).to(beFalse())
      }
      
      it("denotes a good point as being inside the geofence") {
        
        let goodPoint = CLLocationCoordinate2D(latitude: 37.616307, longitude: -122.386158)
        
        expect(GeofenceArbiter.checkLocation(goodPoint, againstFeatures: taxiWaitingZone.features)).to(beTrue())
      }
    }
  }
}
