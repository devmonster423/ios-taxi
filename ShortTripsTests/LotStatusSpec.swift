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
  var map: Map!

  override func spec() {
    describe("the LotStatus") {
      beforeEach {
        self.lotStatus = LotStatus(color: LotStatusEnum.Red, timestamp: NSDate())
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
      }

      it("is non-nil") {
        expect(self.lotStatus).toNot(beNil())
      }

      it("can map") {
        expect(self.lotStatus.mapping(self.map)).toNot(beNil())
      }
    }
  }
}
