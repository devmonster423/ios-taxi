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
        viewController.selectedTerminalId = .international
        viewController.currentHour = 0
        viewController.flightType = .Arrivals
        let navigationController = UINavigationController(rootViewController: viewController)
        
        UIApplication.shared.keyWindow!.rootViewController = navigationController
        let _ = navigationController.view
        let _ = viewController.view
      }
      
      it("is instantiated") {
        expect(viewController).toNot(beNil())
      }
      
      it("can call attemptToHideSpinner") {
        viewController.attemptToHideSpinner()
      }
      
      describe("after loading in fake flight data") {
        beforeEach {
          viewController.flights = [
            Flight(airline: "United Airlines", bags: 5, estimatedTime: Date(), flightStatus: .OnTime, flightNumber: "421", scheduledTime: Date()),
            Flight(airline: "United Airlines", bags: 5, estimatedTime: Date(), flightStatus: .Delayed, flightNumber: "422", scheduledTime: Date()),
            Flight(airline: "United Airlines", bags: 5, estimatedTime: Date(), flightStatus: .Landed, flightNumber: "423", scheduledTime: Date()),
            Flight(airline: "United Airlines", bags: 5, estimatedTime: Date(), flightStatus: .Landing, flightNumber: "424", scheduledTime: Date())
          ]
          viewController.flightStatusView().reloadTableData()
        }
        
        it("supplies data to table view") {
          expect(viewController.tableView(UITableView(), numberOfRowsInSection:0)) == 4
        }
      }
    }
  }
}
