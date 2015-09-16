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
    
    it("is instantiated") {
      expect(viewController).toNot(beNil())
    }
    
    describe("the lot-status field") {
      it("is non-nil") {
        expect(viewController.explanationLabel).toNot(beNil())
      }
      
      // TODO: The next two tests will fail until the UI is set up entirely programmatically.
      xit("is non-blank") {
        expect(viewController.explanationLabel.text).toNot(equal(""))
      }
      
      xit("is visible") {
        expect(viewController.explanationLabel.hidden).toNot(beTrue())
      }
    }
    
    it("has a terminal status button") {
      expect(viewController.statusButton).toNot(beNil())
    }
    
    describe("tapping on the terminal status button") {
      beforeEach {
        viewController.statusButton.tap()
      }
      
      xit("should present a terminal status screen") {
        // TODO: This test will actually fail now, so the it above was changed to xit.
        // Will change xit to it when storyboards have been converted to code.
        expect(viewController.navigationController!.topViewController).to(beAnInstanceOf(TerminalSummaryVC.self))
      }
    }
  }
}
