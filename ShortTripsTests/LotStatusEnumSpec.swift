//
//  LotStatusEnumSpec.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/23/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation

class LotStatusEnumSpec: QuickSpec {
  var lotStatusEnum: LotStatusEnum!

  override func spec() {
    describe("the LotStatusEnum") {
      beforeEach {
        self.lotStatusEnum = LotStatusEnum.random()
      }

      it("is non-nil") {
        expect(self.lotStatusEnum).toNot(beNil())
      }

      it("has a valid value") {
        var valueIsValid = false
        if self.lotStatusEnum == .Green || self.lotStatusEnum == .Red || self.lotStatusEnum == .Yellow {
          valueIsValid = true
        }
        expect(valueIsValid).to(beTrue())
      }
    }
  }
}
