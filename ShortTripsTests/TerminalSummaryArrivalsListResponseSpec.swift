//
//  TerminalSummaryArrivalsListResponseSpec.swift
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

class TerminalSummaryArrivalsListResponseSpec: QuickSpec {
  var terminalSummaryArrivalsList: [TerminalSummary]!
  var terminalSummaryListResponse: TerminalSummaryListResponse!
  var map: Map!
  
  override func spec() {
    describe("the TerminalSummaryArrivalsListResponse") {
      beforeEach {
        self.terminalSummaryArrivalsList = [TerminalSummary(terminalId: TerminalId.International, onTimeCount: 42, delayedCount: 24)]
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
        self.terminalSummaryListResponse = TerminalSummaryListResponse(self.map)
      }
      
      it("is non-nil") {
        expect(self.terminalSummaryListResponse).toNot(beNil())
      }
      
      it("has a TerminalSummaryArrivalsList") {
        expect(self.terminalSummaryArrivalsList[0]).toNot(beNil())
      }
      
      it("can map") {
        expect(self.terminalSummaryListResponse.mapping(self.map)).toNot(beNil())
      }
    }
  }
}

