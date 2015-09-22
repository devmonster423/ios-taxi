//
//  AllCidsResponseSpec.swift
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

class AllCidsResponseSpec: QuickSpec {
  var cidListResponse: CidListResponse!
  var allCidsResponse: AllCidsResponse!
  var allCids: [Cid]!
  var map: Map!
  
  override func spec() {
    describe("the AllCidsResponse") {
      beforeEach {
        self.allCids = [Cid(cidId: 42, cidLocation: "parking lot")]
        self.cidListResponse = CidListResponse(cidList: self.allCids)
        self.allCidsResponse = AllCidsResponse(cidListResponse: self.cidListResponse)
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
      }
      
      it("is non-nil") {
        expect(self.allCidsResponse).toNot(beNil())
      }
      
      it("has a CID list") {
        expect(self.allCids).toNot(beNil())
      }
      
      it("can map") {
        self.allCidsResponse.mapping(self.map)
      }
    }
  }
}

