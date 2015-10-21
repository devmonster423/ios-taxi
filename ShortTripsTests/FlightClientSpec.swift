//
//  FlightClientSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/19/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Mockingjay

class FlightClientSpec: QuickSpec {
  
  override func spec() {
    
    describe("the flight client") {
      it("can request flight details") {
        
        self.stub(uri(Url.Flight.Arrival.details), builder: json(FlightArrivalMock))
        
        ApiClient.requestFlightsForTerminal(1, hour: 1) { flights, statusCode in
          
          expect(flights).toNot(beNil())
        }
      }
      
      it("can request terminal summary") {
        
        self.stub(uri(Url.Flight.Arrival.summary), builder: json(TerminalSummaryMock))
        
        ApiClient.requestTerminalSummary(1) { terminalSummaries, hour, statusCode in
          
          expect(terminalSummaries).toNot(beNil())
        }
      }
    }
  }
}
