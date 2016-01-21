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
  
  var foundInsideObserver: NotificationObserver<[SfoGeofence], AnyObject>?
  var bufferedExitobserver: NotificationObserver<Any?, AnyObject>?
  
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
      
      it("can handle a validlocationRead event") {
        
        var count = 0
        
        self.foundInsideObserver = NotificationObserver(notification: SfoNotification.Geofence.foundInside) { _, _ in
          count = 1
        }
        
        expect(self.foundInsideObserver).toNot(beNil())
        expect(count) == 0
        
        let location = CLLocation(latitude: 37.615716, longitude: -122.388321) // is inside SFO
        postNotification(SfoNotification.Location.read, value: location)
        
        NSRunLoop.mainRunLoop().runUntilDate(NSDate())
        expect(count).toEventually(equal(1), timeout: 10)
      }
      
      it("can correctly call a point outside buffered exit") {
        
        var count = 0
        
        self.bufferedExitobserver = NotificationObserver(notification: SfoNotification.Geofence.outsideBufferedExit) { _, _ in
          count = 1
        }
        
        expect(self.bufferedExitobserver).toNot(beNil())
        expect(count) == 0
        
        let location = CLLocation(latitude: 37.65, longitude: -122.405) // is outside SFO
        postNotification(SfoNotification.Location.read, value: location)
        
        NSRunLoop.mainRunLoop().runUntilDate(NSDate())
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
