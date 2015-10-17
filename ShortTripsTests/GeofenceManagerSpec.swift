//
//  GeofenceManagerSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/16/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import CoreLocation
import JSQNotificationObserverKit

class GeofenceManagerSpec: QuickSpec {
  
  override func spec() {
    
    describe("the geofence manager") {
      
      let geofenceManager = GeofenceManager.sharedInstance
      
      it("can be created") {
        expect(geofenceManager).toNot(beNil())
      }
      
      it("can be started") {
        geofenceManager.start()
        expect(geofenceManager).toNot(beNil())
      }
      
      it("can be stopped") {
        geofenceManager.stop()
        expect(geofenceManager).toNot(beNil())
      }
    }
  }
}
