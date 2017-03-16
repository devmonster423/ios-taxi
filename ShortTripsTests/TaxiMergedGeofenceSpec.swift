//
//  TaxiMergedGeofenceSpec.swift
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

class TaxiMergedGeofenceSpec: QuickSpec {
  
  override func spec() {
    describe("the taxi merged geofence") {
      
      it("can parse") {
        expect(taxiMergedGeofence).toNot(beNil())
        expect(taxiMergedGeofence.sfoGeofence) == SfoGeofence.taxiSfoMerged
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
      
      it("finds a good point in Belmont inside the geofence") {
        
        let sanMateoPoint = CLLocationCoordinate2D(latitude: 37.517546, longitude: -122.286308)
        
        expect(GeofenceArbiter.checkLocation(sanMateoPoint)).to(beTrue())
      }
      
      it("finds a bad point in Belmont outside the geofence") {
        
        let point = CLLocationCoordinate2D(latitude: 37.505563, longitude: -122.289612)
        
        expect(GeofenceArbiter.checkLocation(point)).to(beFalse())
      }
      
      it("finds a good point at Skyline College inside the geofence") {
        
        let point = CLLocationCoordinate2D(latitude: 37.629892, longitude: -122.467411)
        
        expect(GeofenceArbiter.checkLocation(point)).to(beTrue())
      }
      
      it("finds a bad point in Pacifica outside the geofence") {
        
        let point = CLLocationCoordinate2D(latitude: 37.638728, longitude: -122.487710)
        
        expect(GeofenceArbiter.checkLocation(point)).to(beFalse())
      }
      
      it("finds a good point at Geneva and Mission inside the geofence") {
        
        let point = CLLocationCoordinate2D(latitude: 37.716413, longitude: -122.441007)
        
        expect(GeofenceArbiter.checkLocation(point)).to(beTrue())
      }
      
      it("finds a bad point in City College of San Francisco outside the geofence") {
        
        let point = CLLocationCoordinate2D(latitude: 37.725205, longitude: -122.452337)
        
        expect(GeofenceArbiter.checkLocation(point)).to(beFalse())
      }
      
      it("finds a good point at Candlestick Cove inside the geofence") {
        
        let point = CLLocationCoordinate2D(latitude: 37.709029, longitude: -122.393607)
        
        expect(GeofenceArbiter.checkLocation(point)).to(beTrue())
      }
      
      it("finds a bad point on 101 outside the geofence") {
        
        let point = CLLocationCoordinate2D(latitude: 37.716277, longitude: -122.398499)
        
        expect(GeofenceArbiter.checkLocation(point)).to(beFalse())
      }
    }
  }
}
