//
//  PingManagerSpec.swift
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

class PingManagerSpec: QuickSpec {
  
  override func spec() {
    
    describe("the ping manager") {
      
      let pingManager = PingManager.sharedInstance
      
      it("can be created") {
        expect(pingManager).toNot(beNil())
      }
      
      it("can be started") {
        pingManager.start()
        expect(pingManager).toNot(beNil())
      }
      
      it("can process a location") {
        let location = CLLocation(latitude: 37.615716, longitude: -122.388321)
        postNotification(SfoNotification.locationRead, value: location)
        expect(pingManager).toNot(beNil())
      }
      
      it("can be stopped") {
        pingManager.stop()
        expect(pingManager).toNot(beNil())
      }
    }
  }
}
