//
//  ReferenceConfigSpec.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/30/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

class ReferenceConfigSpec: QuickSpec {
  var referenceConfig: ReferenceConfig!
  
  override func spec() {
    describe("the ReferenceConfig") {
      beforeEach {
        self.referenceConfig = ReferenceConfig(JSONString: MockReferenceConfigString)
      }
      
      it("is non-nil") {
        expect(self.referenceConfig).toNot(beNil())
      }
      
      it("is a valid ReferenceConfig") {
        expect(self.referenceConfig.pingInterval).toNot(beNil())
        expect(self.referenceConfig.tripDuration).toNot(beNil())
        expect(self.referenceConfig.gisBuffer).toNot(beNil())
      }
    }
  }
}
