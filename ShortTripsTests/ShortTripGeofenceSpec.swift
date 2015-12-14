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

class ShortTripGeofenceSpec: QuickSpec {

  lazy var entryGateGeofence: LocalGeofence = {
    
    let path = NSBundle.mainBundle().pathForResource("Entry_Gate", ofType: "json")!
    
    var jsonString: String?
    
    do {
      jsonString = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String
    }
    catch {}
    
    return Mapper<LocalGeofence>().map(jsonString!)!
  }()
  
  override func spec() {
    
    describe("the entry gate geofence") {

      it("denotes a bad point as being outside the geofence") {
        
        let badPoint = CLLocationCoordinate2D(latitude: 37.610560, longitude: -122.393328)
        
        expect(GeofenceArbiter.checkLocation(badPoint, againstFeatures: self.entryGateGeofence.features)).to(beFalse())
      }
      
      it("denotes a good point as being inside the geofence") {
        
        let goodPoint = CLLocationCoordinate2D(latitude: 37.615699660000075, longitude: -122.3883)
        
        expect(GeofenceArbiter.checkLocation(goodPoint, againstFeatures: self.entryGateGeofence.features)).to(beTrue())
      }
    }
    
    describe("the short trip geofence") {
      
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
