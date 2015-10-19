//
//  ApiClientSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/25/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble

class ApiClientSpec: QuickSpec {
  
  override func spec() {
    
    describe("the dispatcher client") {
      xit("can request lot status") {
        
        waitUntil(timeout: 60) { done in
          
          ApiClient.requestLotStatus({ status, error in
            
            expect(status).toNot(beNil())
            done()
          })
        }
      }
    }
    
    describe("the geofence client") {
      xit("can request geofences") {
        
        waitUntil(timeout: 60) { done in
          
          ApiClient.requestAllGeofences({ geofences in
            
            expect(geofences).toNot(beNil())
            done()
          })
        }
      }
    }
    
    describe("the geofence client") {
      xit("can request geofences for a given location that should be in SFO geofence") {
        
        waitUntil(timeout: 60) { done in
          
          ApiClient.requestGeofencesForLocation(37.621313,
            longitude: -122.378955,
            buffer: GeofenceArbiter.buffer,
            response: { geofences in
              
              expect(geofences).toNot(beNil())
              done()
          })
        }
      }
    }
    
    describe("the geofence client") {
      xit("can request a specific geofence") {
        
        waitUntil(timeout: 60) { done in
          
          ApiClient.requestGeofenceForLocation(37.7,
            latitude: -122.37,
            buffer: 1,
            response: { geofence, error in
            
              expect(geofence).toNot(beNil())
              done()
          })
        }
      }
    }
  }
}
