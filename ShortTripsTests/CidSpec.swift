//
//  CidSpec.swift
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

class CidSpec: QuickSpec {
  var cid: Cid!
  var map: Map!
  
  override func spec() {
    describe("the CID") {
      beforeEach {
        self.cid = Cid(cidId: 42, cidLocation: "parking lot")
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
      }
      
      it("is non-nil") {
        expect(self.cid).toNot(beNil())
      }
      
      it("can map") {
        self.cid.mapping(self.map)
      }
    }
  }
}
