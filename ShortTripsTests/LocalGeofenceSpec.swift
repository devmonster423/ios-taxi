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
import ObjectMapper

class LocalGeofenceSpec: QuickSpec {
  
  override func spec() {
    describe("the domestic pickup geofence") {
      
      it("can parse") {
        expect(LocalGeofence("Domestic_Pax_Pickup")).toNot(beNil())
      }
    }

    describe("the entry gate geofence") {
      
      it("can parse") {
        expect(LocalGeofence("Entry_Gate")).toNot(beNil())
      }
    }

    describe("the international pickup geofence") {
      
      it("can parse") {
        expect(LocalGeofence("International_Pax_Pickup")).toNot(beNil())
      }
    }

    describe("the sfo geofence") {
      
      it("can parse") {
        expect(LocalGeofence("SFO")).toNot(beNil())
      }
    }
    
    describe("the terminal exit geofence") {
      
      it("can parse") {
        expect(LocalGeofence("Terminal_Exit")).toNot(beNil())
      }
    }

    describe("the valid cities geofence") {
      
      it("can parse") {
        expect(LocalGeofence("Valid_Cities")).toNot(beNil())
      }
    }
    
    describe("the taxi wait zone geofence") {
      
      it("can parse") {
        expect(LocalGeofence("Taxi_Waiting_Zone")).toNot(beNil())
      }
    }
  }
}
