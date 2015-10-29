//
//  TerminalSummaryDResponseSpec.swift
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

class TerminalSummaryDResponseSpec: QuickSpec {
  var terminalSummaryDResponse: TerminalSummaryDResponse!
  var map: Map!
  
  override func spec() {
    describe("the TerminalSummaryDResponse") {
      beforeEach {
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
        self.terminalSummaryDResponse = TerminalSummaryDResponse(self.map)
      }
      
      it("is non-nil") {
        expect(self.terminalSummaryDResponse).toNot(beNil())
      }
      
      it("can map") {
        expect(self.terminalSummaryDResponse.mapping(self.map)).toNot(beNil())
      }
    }
  }
}