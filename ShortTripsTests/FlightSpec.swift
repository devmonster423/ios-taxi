//
//  FlightSpec.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

class FlightSpec: QuickSpec {
  var flight: Flight!
  
  override func spec() {
    describe("the Flight") {
      beforeEach {
        self.flight = Flight(airline: "AerLingus", bags: 5, estimatedTime: Date(), flightStatus: .OnTime, flightNumber: "42", scheduledTime: Date())
      }
      
      it("is non-nil") {
        expect(self.flight).toNot(beNil())
      }
      
      it("can map") {
        expect(self.flight.toJSON()).toNot(beNil())
      }
    }
  }
}
