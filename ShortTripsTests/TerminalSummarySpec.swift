//
//  TerminalSummarySpec.swift
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

class TerminalSummarySpec: QuickSpec {
  var terminalSummary: TerminalSummary!
  var map: Map!
  
  override func spec() {
    describe("the TerminalSummary") {
      beforeEach {
        self.terminalSummary = TerminalSummary(terminalId: TerminalId.International, count: 42, delayedCount: 24)
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
      }
      
      it("is non-nil") {
        expect(self.terminalSummary).toNot(beNil())
      }
      
      it("can map") {
        expect(self.terminalSummary.mapping(self.map)).toNot(beNil())
      }
    }
  }
}
