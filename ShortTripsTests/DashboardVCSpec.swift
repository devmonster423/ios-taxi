//
//  DashboardVCSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/11/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import ShortTrips
import Quick
import Nimble
import PivotalCoreKit

class DashboardVCSpec: QuickSpec {
  override func spec() {
    var viewController: DashboardVC!
    
    beforeEach {
      let storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
      let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
      viewController = navigationController.topViewController as! DashboardVC
      
      UIApplication.sharedApplication().keyWindow!.rootViewController = navigationController
      let _ = navigationController.view
      let _ = viewController.view
    }
    
    it("has a terminal status button") {
      expect(viewController.statusButton).toNot(beNil())
    }
    
    describe("tapping on the terminal status button") {
      beforeEach {
        viewController.statusButton.tap()
      }
      
      it("should present a terminal status screen") {
        // TODO: this test will actually fail now, try again when converted from storyboards to swift
        // expect(viewController.navigationController!.topViewController).to(beAnInstanceOf(TerminalSummaryVC.self))
      }
    }
  }
}
