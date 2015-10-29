//
//  TerminalSummaryDeparturesResponseSpec.swift
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

class TerminalSummaryDeparturesResponseSpec: QuickSpec {
  var terminalSummaryDeparturesResponse: TerminalSummaryDeparturesResponse!
  var map: Map!
  
  override func spec() {
    describe("the TerminalSummaryDeparturesResponse") {
      beforeEach {
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
        self.terminalSummaryDeparturesResponse = TerminalSummaryDeparturesResponse(self.map)
      }
      
      it("is non-nil") {
        expect(self.terminalSummaryDeparturesResponse).toNot(beNil())
      }
      
      it("can map") {
        expect(self.terminalSummaryDeparturesResponse.mapping(self.map)).toNot(beNil())
      }
    }
  }
}