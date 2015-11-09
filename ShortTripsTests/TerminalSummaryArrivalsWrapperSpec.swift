//
//  TerminalSummaryArrivalsWrapperSpec.swift
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

class TerminalSummaryArrivalsWrapperSpec: QuickSpec {
  var terminalSummaryArrivalsWrapper: TerminalSummaryArrivalsWrapper!
  
  override func spec() {
    describe("the TerminalSummaryArrivalsListWrapper") {
      beforeEach {
        self.terminalSummaryArrivalsListWrapper = Mapper<TerminalSummaryArrivalsListWrapper>().map(MockTerminalSummaryArrivalsListWrapperString)
      }
      
      it("is non-nil") {
        expect(self.terminalSummaryArrivalsListWrapper).toNot(beNil())
      }
      
      it("has at least one TerminalSummary") {
        expect (self.terminalSummaryArrivalsListWrapper.terminalSummaries.count) >= 1
      }
    }
  }
}

