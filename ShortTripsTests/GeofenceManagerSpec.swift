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

class GeofenceManagerSpec: QuickSpec {
  
  let nc = NotificationCenter.default
  
  override func spec() {
    
    describe("the geofence manager") {
      
      beforeEach {
        if !Url.isDevUrl() {
          fatalError("can't call this when not logged in")
        }
      }
      
      let geofenceManager = GeofenceManager.sharedInstance
      
      it("can be created") {
        expect(geofenceManager).toNot(beNil())
      }
      
      it("can be started") {
        geofenceManager.start()
        expect(geofenceManager).toNot(beNil())
      }
      
      it("can handle a validlocationRead event") {
        
        var count = 0
        
        self.nc.addObserver(forName: .foundInside, object: nil, queue: nil) { _ in
          count = 1
        }
        
        expect(count) == 0
        
        let location = CLLocation(latitude: 37.615716, longitude: -122.388321) // is inside SFO
        
        self.nc.post(name: .locRead, object: nil, userInfo: [InfoKey.location: location])
        
        RunLoop.main.run(until: Date())
        expect(count).toEventually(equal(1), timeout: 10)
      }
      
      it("can correctly call a point outside buffered exit") {
        
        var count = 0
        
        self.nc.addObserver(forName: .outsideBufferedExit, object: nil, queue: nil) { _ in
          count = 1
        }
        
        expect(count) == 0
        
        let location = CLLocation(latitude: 37.65, longitude: -122.405) // is outside SFO
        self.nc.post(name: .locRead, object: nil, userInfo: [InfoKey.location: location])
        
        RunLoop.main.run(until: Date())
        expect(count).toEventually(equal(1), timeout: 10)
      }
      
      it("can be stopped") {
        geofenceManager.stop()
        expect(geofenceManager).toNot(beNil())
      }
      
      afterEach {
        Failure.sharedInstance.fire()
      }
    }
  }
}
