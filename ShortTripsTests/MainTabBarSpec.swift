//
//  MainTabBarSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/8/16.
//  Copyright © 2016 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import PivotalCoreKit

class MainTabBarSpec: QuickSpec {
  
  override func spec() {
    
    describe("the tab bar controller") {
      
      beforeEach {
        if !Url.isDevUrl() {
          fatalError("can't call this when not logged in")
        }
      }
      
      it("can instantiate") {
        expect(MainTabBarController).toNot(beNil())
      }
    }
  }
}
