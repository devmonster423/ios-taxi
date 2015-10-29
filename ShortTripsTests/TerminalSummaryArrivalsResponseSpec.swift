//
//  TerminalSummaryArrivalsResponseSpec.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/29/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

class TerminalSummaryArrivalsResponseSpec: QuickSpec {
  var terminalSummaryArrivalsResponse: TerminalSummaryArrivalsResponse!
  var map: Map!
  
  override func spec() {
    describe("the TerminalSummaryArrivalsResponse") {
      beforeEach {
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
        self.terminalSummaryArrivalsResponse = TerminalSummaryArrivalsResponse(self.map)
      }
      
      it("is non-nil") {
        expect(self.terminalSummaryArrivalsResponse).toNot(beNil())
      }
      
      it("can map") {
        expect(self.terminalSummaryArrivalsResponse.mapping(self.map)).toNot(beNil())
      }
    }
  }
}