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
  
  override func spec() {
    describe("the Antenna") {
      beforeEach {
        self.antenna = Mapper<Antenna>().map(MockAntennaString)
      }
      
      it("is non-nil") {
        expect(self.antenna).toNot(beNil())
      }
      
      it("is a valid Antenna") {
        expect(self.antenna.antennaId).toNot(beNil())
        expect(self.antenna.aviDate).toNot(beNil())
        expect(self.antenna.aviLocation).toNot(beNil())
        expect(self.antenna.device()).toNot(beNil())
      }
    }
  }
}

