//
//  ValidCitiesGeofenceSpec.swift
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

class ValidCitiesGeofenceSpec: QuickSpec {
  
  override func spec() {
    describe("the valid cities geofence") {
      
      it("can parse") {
        expect(validCitiesGeofence).toNot(beNil())
        expect(validCitiesGeofence.sfoGeofence) == SfoGeofence.TaxiSfoMerged
      }
      it("finds a point in SF outside the geofence") {
        
        let sfPoint = CLLocationCoordinate2D(latitude: 37.752598, longitude: -122.415504)
        
        expect(GeofenceArbiter.checkLocation(sfPoint)).to(beFalse())
      }
      
      it("finds a point in Palo Alto outside the geofence") {
        
        let paloAltoPoint = CLLocationCoordinate2D(latitude: 37.438202, longitude: -122.154922)
        
        expect(GeofenceArbiter.checkLocation(paloAltoPoint)).to(beFalse())
      }
      
      it("finds a point in Brisbane inside the geofence") {
        
        let brisbanePoint = CLLocationCoordinate2D(latitude: 37.681205, longitude: -122.400570)
        
        expect(GeofenceArbiter.checkLocation(brisbanePoint)).to(beTrue())
      }
      
      it("finds a point in San Mateo inside the geofence") {
        
        let sanMateoPoint = CLLocationCoordinate2D(latitude: 37.570909, longitude: -122.317486)
        
        expect(GeofenceArbiter.checkLocation(sanMateoPoint)).to(beTrue())
      }
    }
  }
}