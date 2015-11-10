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
  
  override func spec() {
    describe("the TerminalSummary") {
      beforeEach {
        self.terminalSummary = Mapper<TerminalSummary>().map(MockTerminalSummaryString)
      }
      
      it("is non-nil") {
        expect(self.terminalSummary).toNot(beNil())
      }
    }
  }
}
