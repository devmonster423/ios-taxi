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
  
  override func spec() {
    describe("the AntennaResponse") {
      beforeEach {
        self.antennaResponse = Mapper<AntennaResponse>().map(MockAntennaResponse)
        self.antenna = self.antennaResponse.antenna
      }
      
      it("is non-nil") {
        expect(self.antennaResponse).toNot(beNil())
      }
      
      it("has an Antenna") {
        expect(self.antenna).toNot(beNil())
      }
    }
  }
}
