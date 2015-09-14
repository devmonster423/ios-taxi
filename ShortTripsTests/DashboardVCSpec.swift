//
//  DashboardVCSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/11/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Quick
import Nimble
import PivotalCoreKit

class DashboardVCSpec: QuickSpec {

  override func spec() {

    var viewController: DashboardVC!
    
    beforeEach {
      viewController = DashboardVC()
      let navigationController = UINavigationController(rootViewController: viewController)
      
      UIApplication.sharedApplication().keyWindow!.rootViewController = navigationController
      let _ = navigationController.view
      let _ = viewController.view
    }
    
    describe("when view loads") {
      it("has a terminal status button") {
        expect(viewController.dashboardView().terminalStatusBtn).toNot(beNil())
      }
    }
    
    describe("tapping on the terminal status button") {
      beforeEach {
        viewController.dashboardView().terminalStatusBtn.tap()
      }
      
      it("should present a terminal status screen") {

        // wait for animation to be totally done
        let seconds = 4.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))

        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
          expect(viewController.navigationController!.topViewController).to(beAnInstanceOf(TerminalSummaryVC.self))
        })
      }
    }
  }
}
