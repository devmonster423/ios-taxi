//
//  ShortTripVCSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/11/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import CoreLocation

class ShortTripVCSpec: QuickSpec {
  
  override func spec() {
    
    var viewController: ShortTripVC!
    
    describe("the short trip view controller") {
      
      beforeEach {
        
        if !Url.isDevUrl() {
          fatalError("can't call this when not logged in")
        }
        
        // this is to test that initial text is there in entry cid state
        InsideTaxiWaitingZone.sharedInstance.fire()
        
        viewController = ShortTripVC()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        UIApplication.shared.keyWindow!.rootViewController = navigationController
        let _ = navigationController.view
        let _ = viewController.view
      }
      
      it("is instantiated") {
        expect(viewController).toNot(beNil())
      }
      
      it("can call Util things") {
        UiHelpers.disableWidgetWithAnimation(viewController.view)
        UiHelpers.enableWidgetWithAnimation(viewController.view)
        UiHelpers.displayComingSoonMessage(viewController)
        UiHelpers.displayErrorMessage(viewController, message: "error")
        UiHelpers.displayMessage(viewController, title: "fake title", message: "fake message")
      }
      
      it ("has some initial text in waiting for entry cid state") {
        let machine = StateManager.sharedInstance.getMachine()
        
        // can be initialized
        expect(machine).toNot(beNil())
        
        expect(viewController.shortTripView().getPromptText()).toNot(beNil())
        Failure.sharedInstance.fire()
        expect(machine.is(inState: NotReady.sharedInstance.getState())).to(beTrue())
      }
      
      it("can receive notifications and display things") {
        
        let antenna = Antenna(antennaId: "123", aviLocation: "Location #15 Taxi Main Lot", aviDate: Date())
        let location = CLLocation(latitude: 37.615716, longitude: -122.388321)
        let _ = Ping(location: CLLocation(latitude: 37.615716, longitude: -122.388321),
          tripId: 123,
          vehicleId: 123,
          sessionId: 456,
          medallion: "789")
        let driver = Driver(sessionId: 123, driverId: 234, cardId: "345", firstName: "", lastName: "", driverLicense: "3F0-3xy6y")
        let vehicle = Vehicle(gtmsTripId: 10590,
          licensePlate: "13702K1",
          medallion: "1404",
          transponderId: 2005887,
          vehicleId: 12999)
        
        let nc = NotificationCenter.default
        
        nc.post(name: .foundInside, object: nil, userInfo: [InfoKey.geofences: [SfoGeofence]()])
        
        nc.post(name: .locManagerStarted, object: nil)
        
        nc.post(name: .locRead, object: nil, userInfo: [InfoKey.location: location])
        
        nc.post(name: .response, object: nil, userInfo: [InfoKey.response: HTTPURLResponse(url: URL(string: Url.Flight.Departure.summary)!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!])
        
        nc.post(name: .aviRead, object: nil, userInfo: [InfoKey.antenna: antenna])
        
        nc.post(name: .driverVehicleAssociated, object: nil, userInfo: [InfoKey.driver: driver, InfoKey.vehicle: vehicle])
        
        nc.post(name: .response, object: nil, userInfo: [InfoKey.response: HTTPURLResponse(url: URL(string: Url.Flight.Departure.summary)!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!])
        
        expect(viewController).toNot(beNil())
      }
    }
  }
}
