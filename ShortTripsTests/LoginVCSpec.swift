//
//  LoginVCSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/23/15.
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
        
        DriverCredential.clear()
        
        viewController = LoginVC(startup: false)
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = viewController
        let _ = viewController.view
      }
      
      it("is instantiated") {
        expect(viewController).toNot(beNil())
      }
    }
  }
}
