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

class AutoLoginVCSpec: QuickSpec {
  
  override func spec() {
    
    var viewController: LoginVC!
    
    describe("the dashboard view controller") {
      
      
      beforeEach {
        
        if !Url.isDevUrl() {
          fatalError("can't call this when not logged in")
        }
        
        let driverCredential = DriverCredential(username: "testdriver6", password: "testdriver6@")
        driverCredential.save()
        
        viewController = LoginVC()
        
        UIApplication.shared.keyWindow!.rootViewController = viewController
        let _ = viewController.view
      }
      
      it("is instantiated") {
        expect(viewController).toNot(beNil())
      }
    }
  }
}
