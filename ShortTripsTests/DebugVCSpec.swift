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
        
        postNotification(SfoNotification.Ping.attempting, value: ping)
        
        postNotification(SfoNotification.Geofence.foundInside, value: [Geofence]())
        
        postNotification(SfoNotification.Location.managerStarted, value: nil)
        
        postNotification(SfoNotification.Location.read, value: location)
        
        postNotification(SfoNotification.Request.response, value: NSHTTPURLResponse(URL: NSURL(string: Url.Flight.summary)!, statusCode: 200, HTTPVersion: "HTTP/1.1", headerFields: nil)!)
        
        postNotification(SfoNotification.Ping.successful, value: ping)
        
        expect(viewController).toNot(beNil())
      }
    }
  }
}
