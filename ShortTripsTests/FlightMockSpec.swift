//
//  FlightMockSpec.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/22/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation

class FlightMockSpec: QuickSpec {
  private var flights: [Flight]!
  
  override func spec() {
    beforeEach {
      self.flights = FlightMock.mockFlights()
    }
    
    describe("the mocked-flight array") {
      it("has 15 flights") {
        expect(self.flights.count).to(equal(15))
      }
      
      it("has a Lufthansa flight in position 14") {
        expect(self.flights[14].airline).to(equal(Airline.Lufthansa))
      }
    }
  }
}


