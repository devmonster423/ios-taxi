//
//  TerminalExitGeofenceSpec.swift
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

class TerminalExitGeofenceSpec: QuickSpec {
  
  override func spec() {
    describe("the terminal exit geofence") {
      
      it("can parse") {
        expect(terminalExitGeofence).toNot(beNil())
      }
      
      it("denotes a bad point as being outside the geofence") {
        
        let badPoint = CLLocationCoordinate2D(latitude: 37.648945, longitude: -122.410311)
        
        expect(GeofenceArbiter.checkLocation(badPoint, againstFeatures: terminalExitGeofence.features)).to(beFalse())
      }
      
      it("denotes a good point as being inside the geofence") {
        
        let goodPoint = CLLocationCoordinate2D(latitude: 37.615884, longitude: -122.391408)
        
        expect(GeofenceArbiter.checkLocation(goodPoint, againstFeatures: terminalExitGeofence.features)).to(beTrue())
      }
    }
  }
}
