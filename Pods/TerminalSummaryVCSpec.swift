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
      
      describe("when it appears") {
        beforeEach {
          viewController.viewWillAppear(false)
        }
        
        it("has the SFO logo as a navigation item title") {
          let imageView = viewController.navigationItem.titleView as! UIImageView
          expect(imageView.image).to(equal(Image.sfoLogoAlpha.image()))
        }
      }
    }
  }
}
