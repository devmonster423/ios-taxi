//
//  AntennaSpec.swift
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

class AntennaSpec: QuickSpec {
  var antenna: Antenna!
  var map: Map!
  
  override func spec() {
    describe("the Antenna") {
      beforeEach {
        self.antenna = Antenna(antennaId: 42, aviLocation: "foo")
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
      }
      
      it("is non-nil") {
        expect(self.antenna).toNot(beNil())
      }
      
      it("can map") {
        self.antenna.mapping(self.map)
      }
    }
  }
}
