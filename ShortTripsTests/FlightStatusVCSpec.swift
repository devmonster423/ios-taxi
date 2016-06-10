//
//  FlightStatusVCSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import PivotalCoreKit

class FlightStatusVCSpec: QuickSpec {
  
  override func spec() {
    
    var viewController: FlightStatusVC!
    
    describe("the dashboard view controller") {
      
      beforeEach {
        
        if !Url.isDevUrl() {
          fatalError("can't call this when not logged in")
        }
        
        viewController = FlightStatusVC()
        viewController.selectedTerminalId = .International
        viewController.currentHour = 0
        viewController.flightType = .Arrivals
        let navigationController = UINavigationController(rootViewController: viewController)
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = navigationController
        let _ = navigationController.view
        let _ = viewController.view
      }
      
      it("is instantiated") {
        expect(viewController).toNot(beNil())
      }
      
      describe("after loading in fake flight data") {
        beforeEach {
          viewController.flights = [
            Flight(airline: "United Airlines", bags: 5, estimatedTime: NSDate(), flightStatus: .OnTime, flightNumber: "421", scheduledTime: NSDate()),
            Flight(airline: "United Airlines", bags: 5, estimatedTime: NSDate(), flightStatus: .Delayed, flightNumber: "422", scheduledTime: NSDate()),
            Flight(airline: "United Airlines", bags: 5, estimatedTime: NSDate(), flightStatus: .Landed, flightNumber: "423", scheduledTime: NSDate()),
            Flight(airline: "United Airlines", bags: 5, estimatedTime: NSDate(), flightStatus: .Landing, flightNumber: "424", scheduledTime: NSDate())
          ]
          viewController.flightStatusView().flightTable.reloadData()
        }
        
        it("can display flights") {
          expect(viewController.flightStatusView().flightTable.numberOfSections).to(equal(1))
          expect(viewController.flightStatusView().flightTable.numberOfRowsInSection(0)).to(equal(viewController.flights!.count))
          
          let indexPath = NSIndexPath(forRow: 0, inSection: 0)
          
          expect(viewController.flightStatusView().flightTable.cellForRowAtIndexPath(indexPath)).toNot(beNil())
        }
      }
    }
  }
}
