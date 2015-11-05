//
//  TripScenario4Spec.swift
//  ShortTrips
//
//  Created by Joshua Adams on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble

class TripScenario4Spec: QuickSpec {
  
  override func spec() {
    
    describe("the trip manager") {
      it("can handle scenario 4 with a logout") {
        let machine = StateManager.sharedInstance.getMachine()
        expect(machine).toNot(beNil())
        expect(machine.isInState(NotReady.sharedInstance.getState())).to(beTrue())
        InsideSfo.sharedInstance.fire()
        expect(machine.isInState(WaitingForEntryCid.sharedInstance.getState())).to(beTrue())
        LatestCidIsEntryCid.sharedInstance.fire()
        expect(machine.isInState(AssociatingDriverAndVehicle.sharedInstance.getState())).to(beTrue())
        DriverAndVehicleAssociated.sharedInstance.fire()
        expect(machine.isInState(VerifyingEntryGateAvi.sharedInstance.getState())).to(beTrue())
        EntryGateAVIReadConfirmed.sharedInstance.fire()
        expect(machine.isInState(WaitingInHoldingLot.sharedInstance.getState())).to(beTrue())
        InsideTaxiLoopExit.sharedInstance.fire()
        expect(machine.isInState(WaitingForPaymentCid.sharedInstance.getState())).to(beTrue())
        LatestCidIsPaymentCid.sharedInstance.fire()
        expect(machine.isInState(VerifyingTaxiLoopAvi.sharedInstance.getState())).to(beTrue())
        LatestAviReadAtTaxiLoop.sharedInstance.fire()
        expect(machine.isInState(Ready.sharedInstance.getState())).to(beTrue())
        OutsideSfo.sharedInstance.fire()
        expect(machine.isInState(VerifyingExitAvi.sharedInstance.getState())).to(beTrue())
        LatestAviReadAtExit.sharedInstance.fire()
        expect(machine.isInState(WaitingForStartTrip.sharedInstance.getState())).to(beTrue())
        TripStarted.sharedInstance.fire()
        expect(machine.isInState(InProgress.sharedInstance.getState())).to(beTrue())
        OutsideShortTripGeofence.sharedInstance.fire()
        expect(machine.isInState(NotReady.sharedInstance.getState())).to(beTrue())
        LoggedOut.sharedInstance.fire()
        expect(machine.isInState(NotReady.sharedInstance.getState())).to(beTrue())
        
        // Follow Scenario 1 happy path.
        expect(machine).toNot(beNil())
        expect(machine.isInState(NotReady.sharedInstance.getState())).to(beTrue())
        InsideSfo.sharedInstance.fire()
        expect(machine.isInState(WaitingForEntryCid.sharedInstance.getState())).to(beTrue())
        LatestCidIsEntryCid.sharedInstance.fire()
        expect(machine.isInState(AssociatingDriverAndVehicle.sharedInstance.getState())).to(beTrue())
        DriverAndVehicleAssociated.sharedInstance.fire()
        expect(machine.isInState(VerifyingEntryGateAvi.sharedInstance.getState())).to(beTrue())
        EntryGateAVIReadConfirmed.sharedInstance.fire()
        expect(machine.isInState(WaitingInHoldingLot.sharedInstance.getState())).to(beTrue())
        InsideTaxiLoopExit.sharedInstance.fire()
        expect(machine.isInState(WaitingForPaymentCid.sharedInstance.getState())).to(beTrue())
        LatestCidIsPaymentCid.sharedInstance.fire()
        expect(machine.isInState(VerifyingTaxiLoopAvi.sharedInstance.getState())).to(beTrue())
        LatestAviReadAtTaxiLoop.sharedInstance.fire()
        expect(machine.isInState(Ready.sharedInstance.getState())).to(beTrue())
        OutsideSfo.sharedInstance.fire()
        expect(machine.isInState(VerifyingExitAvi.sharedInstance.getState())).to(beTrue())
        LatestAviReadAtExit.sharedInstance.fire()
        expect(machine.isInState(WaitingForStartTrip.sharedInstance.getState())).to(beTrue())
        TripStarted.sharedInstance.fire()
        expect(machine.isInState(InProgress.sharedInstance.getState())).to(beTrue())
        InsideSfo.sharedInstance.fire()
        expect(machine.isInState(VerifyingInboundAvi.sharedInstance.getState())).to(beTrue())
        LatestAviReadInbound.sharedInstance.fire()
        expect(machine.isInState(ValidatingTrip.sharedInstance.getState())).to(beTrue())
        TripValidated.sharedInstance.fire()
        expect(machine.isInState(NotReady.sharedInstance.getState())).to(beTrue())
      }
      
      it("can handle scenario 4 with an app quit") {
        let machine = StateManager.sharedInstance.getMachine()
        expect(machine).toNot(beNil())
        expect(machine.isInState(NotReady.sharedInstance.getState())).to(beTrue())
        InsideSfo.sharedInstance.fire()
        expect(machine.isInState(WaitingForEntryCid.sharedInstance.getState())).to(beTrue())
        LatestCidIsEntryCid.sharedInstance.fire()
        expect(machine.isInState(AssociatingDriverAndVehicle.sharedInstance.getState())).to(beTrue())
        DriverAndVehicleAssociated.sharedInstance.fire()
        expect(machine.isInState(VerifyingEntryGateAvi.sharedInstance.getState())).to(beTrue())
        EntryGateAVIReadConfirmed.sharedInstance.fire()
        expect(machine.isInState(WaitingInHoldingLot.sharedInstance.getState())).to(beTrue())
        InsideTaxiLoopExit.sharedInstance.fire()
        expect(machine.isInState(WaitingForPaymentCid.sharedInstance.getState())).to(beTrue())
        LatestCidIsPaymentCid.sharedInstance.fire()
        expect(machine.isInState(VerifyingTaxiLoopAvi.sharedInstance.getState())).to(beTrue())
        LatestAviReadAtTaxiLoop.sharedInstance.fire()
        expect(machine.isInState(Ready.sharedInstance.getState())).to(beTrue())
        OutsideSfo.sharedInstance.fire()
        expect(machine.isInState(VerifyingExitAvi.sharedInstance.getState())).to(beTrue())
        LatestAviReadAtExit.sharedInstance.fire()
        expect(machine.isInState(WaitingForStartTrip.sharedInstance.getState())).to(beTrue())
        TripStarted.sharedInstance.fire()
        expect(machine.isInState(InProgress.sharedInstance.getState())).to(beTrue())
        OutsideShortTripGeofence.sharedInstance.fire()
        expect(machine.isInState(NotReady.sharedInstance.getState())).to(beTrue())
        AppQuit.sharedInstance.fire()
        expect(machine.isInState(NotReady.sharedInstance.getState())).to(beTrue())
        
        // Follow Scenario 1 happy path.
        expect(machine).toNot(beNil())
        expect(machine.isInState(NotReady.sharedInstance.getState())).to(beTrue())
        InsideSfo.sharedInstance.fire()
        expect(machine.isInState(WaitingForEntryCid.sharedInstance.getState())).to(beTrue())
        LatestCidIsEntryCid.sharedInstance.fire()
        expect(machine.isInState(AssociatingDriverAndVehicle.sharedInstance.getState())).to(beTrue())
        DriverAndVehicleAssociated.sharedInstance.fire()
        expect(machine.isInState(VerifyingEntryGateAvi.sharedInstance.getState())).to(beTrue())
        EntryGateAVIReadConfirmed.sharedInstance.fire()
        expect(machine.isInState(WaitingInHoldingLot.sharedInstance.getState())).to(beTrue())
        InsideTaxiLoopExit.sharedInstance.fire()
        expect(machine.isInState(WaitingForPaymentCid.sharedInstance.getState())).to(beTrue())
        LatestCidIsPaymentCid.sharedInstance.fire()
        expect(machine.isInState(VerifyingTaxiLoopAvi.sharedInstance.getState())).to(beTrue())
        LatestAviReadAtTaxiLoop.sharedInstance.fire()
        expect(machine.isInState(Ready.sharedInstance.getState())).to(beTrue())
        OutsideSfo.sharedInstance.fire()
        expect(machine.isInState(VerifyingExitAvi.sharedInstance.getState())).to(beTrue())
        LatestAviReadAtExit.sharedInstance.fire()
        expect(machine.isInState(WaitingForStartTrip.sharedInstance.getState())).to(beTrue())
        TripStarted.sharedInstance.fire()
        expect(machine.isInState(InProgress.sharedInstance.getState())).to(beTrue())
        InsideSfo.sharedInstance.fire()
        expect(machine.isInState(VerifyingInboundAvi.sharedInstance.getState())).to(beTrue())
        LatestAviReadInbound.sharedInstance.fire()
        expect(machine.isInState(ValidatingTrip.sharedInstance.getState())).to(beTrue())
        TripValidated.sharedInstance.fire()
        expect(machine.isInState(NotReady.sharedInstance.getState())).to(beTrue())
      }
    }
  }
}
