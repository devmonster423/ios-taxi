//
//  DebugVCSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import PivotalCoreKit
import JSQNotificationObserverKit
import CoreLocation

class DebugVCSpec: QuickSpec {
  
  override func spec() {
    
    var viewController: DebugVC!
    
    describe("the dashboard view controller") {
      
      beforeEach {
        viewController = DebugVC()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = navigationController
        let _ = navigationController.view
        let _ = viewController.view
      }
      
      it("is instantiated") {
        expect(viewController).toNot(beNil())
      }
      
      it("can receive notifications and debug things") {
        
        let location = CLLocation(latitude: 37.615716, longitude: -122.388321)
        let ping = Ping(location: location)
        
        postNotification(SfoNotification.attemptingPing, value: ping)
        
        postNotification(SfoNotification.foundInsideGeofences, value: [Geofence]())
        
        postNotification(SfoNotification.locationManagerStarted, value: nil)
        
        postNotification(SfoNotification.locationRead, value: location)
        
        postNotification(SfoNotification.requestResponse, value: NSHTTPURLResponse(URL: NSURL(string: Url.Flight.summary)!, statusCode: 200, HTTPVersion: "HTTP/1.1", headerFields: nil)!)
        
        postNotification(SfoNotification.successfulPing, value: ping)
        
        expect(viewController).toNot(beNil())
      }
    }
  }
}
