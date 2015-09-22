//
//  FlightDetailResponseSpec.swift
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

class FlightDetailResponseSpec: QuickSpec {
  var flightDetailResponse: FlightDetailResponse!
  var flightDetails: [Flight]!
  var map: Map!
  
  override func spec() {
    describe("the FlightsForTerminalResponse") {
      beforeEach {
        self.flightDetails = [
          Flight(airline: .AerLingus, bags: 5, estimatedTime: NSDate(), flightStatus: .OnTime, flightNumber: "42", scheduledTime: NSDate())
          ]
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
        self.flightDetailResponse = FlightDetailResponse(self.map)
        self.flightDetailResponse.flightDetails = self.flightDetails
      }
      
      it("is non-nil") {
        expect(self.flightDetailResponse).toNot(beNil())
      }
      
      it("has a flightDetails") {
        expect(self.flightDetails).toNot(beNil())
      }
      
      it("has a Flight") {
        expect(self.flightDetailResponse.flightDetails[0]).toNot(beNil())
      }
      
      it("can map") {
        expect(self.flightDetailResponse.mapping(self.map)).toNot(beNil())
      }
    }
  }
}
