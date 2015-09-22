//
//  CidResponseSpec.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/22/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

class CidResponseSpec: QuickSpec {
  var cid: Cid!
  var cidResponse: CidResponse!
  var map: Map!
  
  override func spec() {
    describe("the CidResponse") {
      beforeEach {
        self.cid = Cid(cidId: 42, cidLocation: "parking lot")
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
        self.cidResponse = CidResponse(self.map)
        self.cidResponse.cid = self.cid
      }
      
      it("is non-nil") {
        expect(self.cidResponse).toNot(beNil())
      }
      
      it("has a CID") {
        expect(self.cid).toNot(beNil())
      }
      
      it("can map") {
        self.cidResponse.mapping(self.map)
      }
    }
  }
}

