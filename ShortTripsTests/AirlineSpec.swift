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
  private var aerLingus: Airline = .AerLingus
  private var lufthansa: Airline = .Lufthansa
  private var airFrance: Airline = .AirFrance
  private var britishAirways: Airline = .BritishAirways
  private var deltaAirlines: Airline = .DeltaAirlines
  private var unitedAirlines: Airline = .UnitedAirlines
  private var virginAmerica: Airline = .VirginAmerica
  
  override func spec() {
    describe("the Airline") {
      it("can be tested against another Airline for identity") {
        expect(self.aerLingus).to(equal(Airline.AerLingus))
        expect(self.lufthansa).to(equal(Airline.Lufthansa))
        expect(self.airFrance).to(equal(Airline.AirFrance))
        expect(self.britishAirways).to(equal(Airline.BritishAirways))
        expect(self.deltaAirlines).to(equal(Airline.DeltaAirlines))
        expect(self.unitedAirlines).to(equal(Airline.UnitedAirlines))
        expect(self.virginAmerica).to(equal(Airline.VirginAmerica))
      }
      
      it("has the correct icon") {
        expect(self.aerLingus.icon()).to(equal(UIImage(named: "AerLingus")!))
        expect(self.lufthansa.icon()).to(equal(UIImage(named: "Lufthansa")!))
        expect(self.airFrance.icon()).to(equal(UIImage(named: "AirFrance")!))
        expect(self.britishAirways.icon()).to(equal(UIImage(named: "BritishAirways")!))
        expect(self.deltaAirlines.icon()).to(equal(UIImage(named: "DeltaAirlines")!))
        expect(self.unitedAirlines.icon()).to(equal(UIImage(named: "UnitedAirlines")!))
        expect(self.virginAmerica.icon()).to(equal(UIImage(named: "VirginAmerica")!))
      }
    }
  }
}
