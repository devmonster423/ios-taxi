//
//  LotStatusSpec.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/23/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

class LotStatusSpec: QuickSpec {
  var lotStatus: LotStatus!
  
  override func spec() {
    describe("the LotStatus") {
      beforeEach {
        self.lotStatus = Mapper<LotStatus>().map(MockLotStatusString)
      }
      
      it("is non-nil") {
        expect(self.lotStatus).toNot(beNil())
      }
      
      it("is a valid LotStatus") {
        expect(self.lotStatus.color).toNot(beNil())
        expect(self.lotStatus.timestamp).toNot(beNil())
      }
    }
  }
}
