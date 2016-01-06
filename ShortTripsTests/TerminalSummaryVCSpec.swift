//
//  TerminalSummaryVCSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import PivotalCoreKit

class TerminalSummaryVCSpec: QuickSpec {
  
  override func spec() {
    
    var viewController: TerminalSummaryVC!
    
    describe("the dashboard view controller") {
      
      beforeEach {
        viewController = TerminalSummaryVC()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = navigationController
        let _ = navigationController.view
        let _ = viewController.view
      }
      
      it("is instantiated") {
        expect(viewController).toNot(beNil())
      }
      
      describe("tapping the plus from +1") {
        
        beforeEach {
          viewController.terminalSummaryView().increaseButton.tap()
        }
        
        it ("increases hour by one") {
          expect(viewController.terminalSummaryView().getCurrentHour()) == 2
        }
      }
      
      describe("tapping the minus once from +1") {
        
        beforeEach {
          viewController.terminalSummaryView().decreaseButton.tap()
        }
        
        it ("decreases hour by two") {
          expect(viewController.terminalSummaryView().getCurrentHour()) == -1
        }
      }
      
      describe("tapping the minus twice from +1") {
        
        beforeEach {
          viewController.terminalSummaryView().decreaseButton.tap()
          viewController.terminalSummaryView().decreaseButton.tap()
        }
        
        it ("decreases hour by three") {
          expect(viewController.terminalSummaryView().getCurrentHour()) == -2
        }
      }

      describe("tapping the minus then plus from +1") {
        
        beforeEach {
          viewController.terminalSummaryView().decreaseButton.tap()
          viewController.terminalSummaryView().increaseButton.tap()
        }
        
        it ("decreases hour by one") {
          expect(viewController.terminalSummaryView().getCurrentHour()) == 1
        }
      }
    }
  }
}
