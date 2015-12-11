//
//  GtmsLocationSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/11/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

class GtmsLocationSpec: QuickSpec {
  
  override func spec() {
    describe("a GtmsLocation") {
      
      it("can be made from a cid string") {
        expect(GtmsLocation.from(cidId: "CID11")) == .TaxiEntry
        expect(GtmsLocation.from(cidId: "CID21")) == .TaxiMainLot
        expect(GtmsLocation.from(cidId: "CID31")) == .NonDispatchedTaxiExit
        expect(GtmsLocation.from(cidId: "CID41")) == .TaxiStatus
        expect(GtmsLocation.from(cidId: "whatever")).to(beNil())
      }
      
      it("can be made from an avi string") {
        expect(GtmsLocation.from(aviId: "L1AVI1")) == .DtEntrance
        expect(GtmsLocation.from(aviId: "L2AVI1")) == .Exit
        expect(GtmsLocation.from(aviId: "L4AVI1")) == .CourtyardG
        expect(GtmsLocation.from(aviId: "L5AVI1")) == .ItdExit
        expect(GtmsLocation.from(aviId: "L6AVI1")) == .CourtyardA
        expect(GtmsLocation.from(aviId: "L7AVI1")) == .ItaEntrance
        expect(GtmsLocation.from(aviId: "L8AVI1")) == .ItdEntrance
        expect(GtmsLocation.from(aviId: "L9AVI1")) == .DtaEntrance
        expect(GtmsLocation.from(aviId: "L10AVI1")) == .TaxiBailOut
        expect(GtmsLocation.from(aviId: "L11AVI1")) == .DtdEntrance
        expect(GtmsLocation.from(aviId: "L12AVI1")) == .DtaRecirculation
        expect(GtmsLocation.from(aviId: "L13AVI1")) == .DtaExit
        expect(GtmsLocation.from(aviId: "L14AVI1")) == .DtdRecirculation
        expect(GtmsLocation.from(aviId: "L15AVI1")) == .TaxiMainLot
        expect(GtmsLocation.from(aviId: "L16AVI1")) == .NonDispatchedTaxiExit
        expect(GtmsLocation.from(aviId: "L17AVI1")) == .TaxiStatus
        expect(GtmsLocation.from(aviId: "L18AVI1")) == .LotCc
        expect(GtmsLocation.from(aviId: "L19AVI1")) == .DomesticArrivalTerminal1
        expect(GtmsLocation.from(aviId: "L20AVI1")) == .DomesticArrivalTerminal2
        expect(GtmsLocation.from(aviId: "L27AVI1")) == .TaxiEntry
        expect(GtmsLocation.from(aviId: "L33AVI1")) == .GtuArea
        expect(GtmsLocation.from(aviId: "L35AVI1")) == .RentalCar
        expect(GtmsLocation.from(aviId: "whatever")).to(beNil())
      }
    }
  }
}
