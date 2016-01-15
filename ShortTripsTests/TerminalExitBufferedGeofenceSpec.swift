//
//  TerminalExitBufferedGeofenceSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/15/16.
//  Copyright © 2016 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import CoreLocation

class TerminalExitBufferedGeofenceSpec: QuickSpec {
  
  override func spec() {
    describe("the terminal exit buffered geofence") {
      
      it("can parse") {
        expect(terminalExitBufferedGeofence).toNot(beNil())
        expect(terminalExitBufferedGeofence.sfoGeofence) == SfoGeofence.TaxiExitBuffered
      }
      
      it("denotes a bad point as being outside the geofence") {
        
        let badPoint = CLLocationCoordinate2D(latitude: 37.617729, longitude: -122.398403)
        
        expect(GeofenceArbiter.checkLocation(badPoint, againstFeatures: terminalExitBufferedGeofence.features)).to(beFalse())
      }
      
      it("denotes a good point as being inside the geofence") {
        
//        let goodPoint = CLLocationCoordinate2D(latitude: 37.614695, longitude: -122.39468)
        
        let goodPoint = CLLocationCoordinate2D(latitude: 37.615205, longitude: -122.39307)
        
        expect(GeofenceArbiter.checkLocation(goodPoint, againstFeatures: terminalExitBufferedGeofence.features)).to(beTrue())
      }
    }
  }
}
