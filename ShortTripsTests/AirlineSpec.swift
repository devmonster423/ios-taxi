//
//  AirlineSpec.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation

class AirlineSpec: QuickSpec {
  private var testAirline: Airline!
  
  override func spec() {
    beforeEach {
      self.testAirline = Airline.AerLingus
    }
    
    describe("the Airline") {
      it("can be tested against another Airline for identity") {
        expect(self.testAirline).to(equal(Airline.AerLingus))
      }
      
      it("has the correct icon") {
        expect(self.testAirline.icon()).to(equal(UIImage(named: "AerLingus")!))
      }
    }
  }
}
