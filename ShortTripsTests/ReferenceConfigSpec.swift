//
//  ReferenceConfigSpec.swift
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

class ReferenceConfigSpec: QuickSpec {
  var referenceConfig: ReferenceConfig!
  var map: Map!
  
  override func spec() {
    describe("the ReferenceConfig") {
      beforeEach {
        self.referenceConfig = ReferenceConfig(pingInterval: 42, tripDuration: 42, gisBuffer: 42)
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
      }
      
      it("is non-nil") {
        expect(self.referenceConfig).toNot(beNil())
      }
      
      it("can map") {
        self.referenceConfig.mapping(self.map)
      }
    }
  }
}
