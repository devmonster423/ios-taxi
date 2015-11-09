//
//  TerminalSummaryDeparturesListWrapperSpec.swift
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

class TerminalSummaryDeparturesListWrapperSpec: QuickSpec {
  var terminalSummaryDeparturesListWrapper: TerminalSummaryDeparturesListWrapper!
  
  override func spec() {
    describe("the TerminalSummaryDeparturesListWrapper") {
      beforeEach {
        self.terminalSummaryDeparturesListWrapper = Mapper<TerminalSummaryDeparturesListWrapper>().map(MockTerminalSummaryDeparturesListWrapperString)
      }
      
      it("is non-nil") {
        expect(self.terminalSummaryDeparturesListWrapper).toNot(beNil())
      }
      
      it("has at least one TerminalSummary") {
        expect (self.terminalSummaryDeparturesListWrapper.terminalSummaries.count) >= 1
      }
    }
  }
}

