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
  private var onTime: FlightStatus = .OnTime
  private var landing: FlightStatus = .Landing
  private var delayed: FlightStatus = .Delayed
  private var landed: FlightStatus = .Landed
  
  override func spec() {
    
    describe("the FlightStatus") {
      it("can be tested against another FlightStatus for identity") {
        expect(self.onTime).to(equal(FlightStatus.OnTime))
        expect(self.landing).to(equal(FlightStatus.Landing))
        expect(self.delayed).to(equal(FlightStatus.Delayed))
        expect(self.landed).to(equal(FlightStatus.Landed))
      }
      
      it("has the correct status color") {
        expect(self.onTime.getStatusColor()).to(equal(Color.FlightStatus.onTime))
        expect(self.landing.getStatusColor()).to(equal(Color.FlightStatus.landing))
        expect(self.delayed.getStatusColor()).to(equal(Color.FlightStatus.delayed))
        expect(self.landed.getStatusColor()).to(equal(Color.FlightStatus.landed))
      }
      
      it("has the correct time-or-flight-number color") {
        expect(self.onTime.getTimeOrFlightNumberColor()).to(equal(Color.FlightStatus.landed))
        expect(self.landing.getTimeOrFlightNumberColor()).to(equal(Color.FlightStatus.landed))
        expect(self.delayed.getTimeOrFlightNumberColor()).to(equal(Color.FlightStatus.delayed))
        expect(self.landed.getTimeOrFlightNumberColor()).to(equal(Color.FlightStatus.landed))
      }      
    }
  }
}
