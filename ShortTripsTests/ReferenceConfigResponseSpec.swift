//
//  ReferenceConfigResponseSpec.swift
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

class ReferenceConfigResponseSpec: QuickSpec {
  var referenceConfig: ReferenceConfig!
  var referenceConfigResponse: ReferenceConfigResponse!
  var map: Map!
  
  override func spec() {
    describe("the ReferenceConfigResponse") {
      beforeEach {
        self.referenceConfig = ReferenceConfig(pingInterval: 42, tripDuration: 42, gisBuffer: 42)
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
        self.referenceConfigResponse = ReferenceConfigResponse(self.map)
        self.referenceConfigResponse.referenceConfig = self.referenceConfig
      }
      
      it("is non-nil") {
        expect(self.referenceConfigResponse).toNot(beNil())
      }
      
      it("has a ReferenceConfig") {
        expect(self.referenceConfig).toNot(beNil())
      }
      
      it("can map") {
        self.referenceConfigResponse.mapping(self.map)
      }
    }
  }
}

