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
        viewController = FlightStatusVC()
        viewController.selectedTerminalId = .International
        viewController.currentHour = 0
        let navigationController = UINavigationController(rootViewController: viewController)
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = navigationController
        let _ = navigationController.view
        let _ = viewController.view
      }
      
      it("is instantiated") {
        expect(viewController).toNot(beNil())
      }
      
      it("can display flights") {
        viewController.flights = [Flight(airline: "United Airlines", bags: 5, estimatedTime: NSDate(), flightStatus: .OnTime, flightNumber: "42", scheduledTime: NSDate())]
        viewController.flightStatusView().flightTable.reloadData()
        expect(viewController.flightStatusView().flightTable.visibleCells.count).to(equal(1))
      }
    }
  }
}
