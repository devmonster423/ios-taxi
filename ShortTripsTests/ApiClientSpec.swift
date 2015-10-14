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
    
    describe("the airline client") {
      it("can request codes") {
        
        waitUntil(timeout: 60) { done in
          
          ApiClient.codes({ airlines, error in
            
            expect(airlines).toNot(beNil())
            done()
          })
        }
      }
    }
    
    describe("the dispatcher client") {
      it("can request lot status") {
        
        waitUntil(timeout: 60) { done in
          
          ApiClient.requestLotStatus({ status, error in
            
            expect(status).toNot(beNil())
            done()
          })
        }
      }
    }
    
    describe("the geofence client") {
      it("can request geofences") {
        
        waitUntil(timeout: 60) { done in
          
          ApiClient.requestAllGeofences({ geofences in
            
            expect(geofences).toNot(beNil())
            done()
          })
        }
      }
    }
    
    describe("the geofence client") {
      it("can request a specific geofence") {
        
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
