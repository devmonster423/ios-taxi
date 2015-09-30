//
//  TerminalSummaryResponseSpec.swift
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

class TerminalSummaryResponseSpec: QuickSpec {
  var terminalSummary: TerminalSummary!
  var terminalSummaryResponse: TerminalSummaryResponse!
  var map: Map!
  
  override func spec() {
    describe("the TerminalSummaryResponse") {
      beforeEach {
        self.terminalSummary = TerminalSummary(terminalId: TerminalId.International, count: 42, delayedCount: 24)
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
        self.terminalSummaryResponse = TerminalSummaryResponse(self.map)
      }
      
      it("is non-nil") {
        expect(self.terminalSummaryResponse).toNot(beNil())
      }
      
      it("has a TerminalSummary") {
        expect(self.terminalSummary).toNot(beNil())
      }
      
      it("can map") {
        expect(self.terminalSummaryResponse.mapping(self.map)).toNot(beNil())
      }
    }
  }
}
