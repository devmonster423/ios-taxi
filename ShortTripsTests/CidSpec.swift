//
//  CidSpec.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/22/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

class CidSpec: QuickSpec {
  var cid: Cid!
  
  override func spec() {
    describe("the CID") {
      beforeEach {
        self.cid = Mapper<Cid>().map(MockCidString)
      }
      
      it("is non-nil") {
        expect(self.cid).toNot(beNil())
      }
      
      it("is a valid CID") {
        expect(self.cid.cidId).toNot(beNil())
        expect(self.cid.cidLocation).toNot(beNil())
        expect(self.cid.cidTimeRead).toNot(beNil())
      }
    }
  }
}
