//
//  TerminalSummaryDeparturesWrapperSpec.swift
//  ShortTrips
//
//  Created by Joshua Adams on 11/8/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

class TerminalSummaryDeparturesWrapperSpec: QuickSpec {
  var terminalSummaryDeparturesWrapper: TerminalSummaryDeparturesWrapper!
  
  override func spec() {
    describe("the TerminalSummaryDeparturesWrapper") {
      beforeEach {
        self.terminalSummaryDeparturesWrapper = Mapper<TerminalSummaryDeparturesWrapper>().map(MockTerminalSummaryDeparturesWrapperString)
      }
      
      it("is non-nil") {
        expect(self.terminalSummaryDeparturesWrapper).toNot(beNil())
      }
      
      it("has at least one TerminalSummary") {
        expect (self.terminalSummaryDeparturesWrapper.terminalSummaries.count) >= 1
      }
    }
  }
}

