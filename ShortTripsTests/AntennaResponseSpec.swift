//
//  AntennaResponseSpec.swift
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

class AntennaResponseSpec: QuickSpec {
  var antenna: Antenna!
  var antennaResponse: AntennaResponse!
  var map: Map!
  
  override func spec() {
    describe("the AntennaResponse") {
      beforeEach {
        self.antenna = Antenna(antennaId: 42, aviLocation: "foo")
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
        self.antennaResponse = AntennaResponse(self.map)
        self.antennaResponse.antenna = self.antenna
      }
      
      it("is non-nil") {
        expect(self.antennaResponse).toNot(beNil())
      }
      
      it("has an Antenna") {
        expect(self.antenna).toNot(beNil())
      }
      
      it("can map") {
        self.antennaResponse.mapping(self.map)
      }
    }
  }
}
