//
//  LoginVCSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import PivotalCoreKit

class LoginVCSpec: QuickSpec {
  
  override func spec() {
    
    var viewController: LoginVC!
    
    describe("the dashboard view controller") {
      
      beforeEach {
        viewController = LoginVC()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = navigationController
        let _ = navigationController.view
        let _ = viewController.view
      }
      
      it("is instantiated") {
        expect(viewController).toNot(beNil())
      }
    }
  }
}
