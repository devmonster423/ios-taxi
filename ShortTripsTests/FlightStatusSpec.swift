//
//  FlightStatusSpec.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation

class FlightStatusSpec: QuickSpec {
  private var testFlightStatus: FlightStatus!
  
  override func spec() {
    beforeEach {
      self.testFlightStatus = FlightStatus.OnTime
    }
    
    describe("the FlightStatus") {
      it("can be tested against another FlightStatus for identity") {
        expect(self.testFlightStatus).to(equal(FlightStatus.OnTime))
      }
      
      it("has the correct status color") {
        expect(self.testFlightStatus.getStatusColor()).to(equal(Color.FlightStatus.onTime))
      }
    }
  }
}
