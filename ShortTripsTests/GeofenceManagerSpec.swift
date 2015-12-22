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
  
  var observer: NotificationObserver<[SfoGeofence], AnyObject>?
  
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
      
      xit("can handle a validlocationRead event") {
        
        var count = 0
        
        self.observer = NotificationObserver(notification: SfoNotification.Geofence.foundInside, handler: { (value, sender) -> Void in
          count = 1
        })
        
        expect(self.observer).toNot(beNil())
        
        let location = CLLocation(latitude: 37.615716, longitude: -122.388321) // is inside SFO
        postNotification(SfoNotification.Location.read, value: location)
        
        expect(count).toEventually(equal(1), timeout: 1)
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
