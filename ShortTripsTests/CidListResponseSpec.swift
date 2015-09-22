//
//  CidListResponseSpec.swift
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

class CidListResponseSpec: QuickSpec {
  var cidList: [Cid]!
  var cidListResponse: CidListResponse!
  var map: Map!
  
  override func spec() {
    describe("the CidListResponse") {
      beforeEach {
        self.cidList = [Cid(cidId: 42, cidLocation: "parking lot")]
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
        self.cidListResponse = CidListResponse(self.map)
        self.cidListResponse.cidList = self.cidList
      }
      
      it("is non-nil") {
        expect(self.cidListResponse).toNot(beNil())
      }
      
      it("has a CID list") {
        expect(self.cidList).toNot(beNil())
      }
      
      it("can map") {
        expect(self.cidListResponse.mapping(self.map)).toNot(beNil())
      }
    }
  }
}

