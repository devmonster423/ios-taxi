//
//  TerminalSummaryArrivalsResponse.swift
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

class TerminalSummaryArrivalsSpec: QuickSpec {
  var terminalSummaries: [TerminalSummary]!
  var terminalSummaryArrivalsResponse: TerminalSummaryArrivalsResponse!
  var terminalSummaryArrivalsListResponse: TerminalSummaryArrivalsListResponse!

  var map: Map!
  
  override func spec() {
    describe("the TerminalSummaryArrivalsResponse") {
      beforeEach {
        self.terminalSummaries = [TerminalSummary(terminalId: TerminalId.International, count: 42, delayedCount: 24)]
        self.terminalSummaryArrivalsListResponse = TerminalSummaryArrivalsListResponse(terminalSummaryArrivalsList: self.terminalSummaries)
        self.terminalSummaryArrivalsResponse = TerminalSummaryArrivalsResponse(terminalSummaryArrivalsListResponse: self.terminalSummaryArrivalsListResponse)
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
      }
      
      it("is non-nil") {
        expect(self.terminalSummaryArrivalsResponse).toNot(beNil())
      }
      
      it("has a TerminalSummaryArrivalsListResponse") {
        expect(self.terminalSummaryArrivalsListResponse).toNot(beNil())
      }
      
      it("can map") {
        expect(self.terminalSummaryArrivalsResponse.mapping(self.map)).toNot(beNil())
      }
    }
  }
}
