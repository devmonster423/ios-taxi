//
//  TerminalSummaryAResponseSpec.swift
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

class TerminalSummaryAResponseSpec: QuickSpec {
  var terminalSummaryAResponse: TerminalSummaryAResponse!
  var map: Map!
  
  override func spec() {
    describe("the TerminalSummaryAResponse") {
      beforeEach {
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
        self.terminalSummaryAResponse = TerminalSummaryAResponse(self.map)
      }
      
      it("is non-nil") {
        expect(self.terminalSummaryAResponse).toNot(beNil())
      }
      
      it("can map") {
        expect(self.terminalSummaryAResponse.mapping(self.map)).toNot(beNil())
      }
    }
  }
}