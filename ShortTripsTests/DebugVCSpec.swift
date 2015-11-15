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
        
        let antenna = Antenna(antennaId: "123", aviLocation: "Location #15 Taxi Main Lot", aviDate: NSDate())
        let location = CLLocation(latitude: 37.615716, longitude: -122.388321)
        let ping = Ping(location: CLLocation(latitude: 37.615716, longitude: -122.388321), tripId: 123, sessionId: 456, medallion: 789)
        let driver = Driver(sessionId: 123, driverId: 234, cardId: "345", firstName: "", lastName: "", driverLicense: "3F0-3xy6y")
        let vehicle = Vehicle(gtmsTripId: 10590,
          licensePlate: "13702K1",
          medallion: 1404,
          transponderId: 2005887,
          vehicleId: 12999)
        
        postNotification(SfoNotification.Ping.attempting, value: ping)
        
        postNotification(SfoNotification.Geofence.foundInside, value: [Geofence]())
        
        postNotification(SfoNotification.Location.managerStarted, value: nil)
        
        postNotification(SfoNotification.Location.read, value: location)
        
        postNotification(SfoNotification.Request.response, value: NSHTTPURLResponse(URL: NSURL(string: Url.Flight.summary)!, statusCode: 200, HTTPVersion: "HTTP/1.1", headerFields: nil)!)

        postNotification(SfoNotification.Ping.attempting, value: ping)
        
        postNotification(SfoNotification.Avi.entryGate, value: antenna)
        
        postNotification(SfoNotification.Driver.vehicleAssociated, value: (driver: driver, vehicle: vehicle))
        
        postNotification(SfoNotification.Request.response, value: NSHTTPURLResponse(URL: NSURL(string: Url.Flight.summary)!, statusCode: 200, HTTPVersion: "HTTP/1.1", headerFields: nil)!)
        
        postNotification(SfoNotification.Ping.successful, value: ping)
        
        expect(viewController).toNot(beNil())
      }
    }
  }
}
