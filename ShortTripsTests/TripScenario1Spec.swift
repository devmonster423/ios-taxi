//
//  StateManagerSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/5/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble

class TripScenario1Spec: QuickSpec {
  
  override func spec() {
    
    describe("the trip manager") {

      it("can handle scenario 1") {
        let machine = StateManager.sharedInstance.getMachine()

        // can be initialized
        expect(machine).toNot(beNil())
        
        // has initial state of not ready
        expect(machine.isInState(NotReady.sharedInstance.getState())).to(beTrue())
      
        InsideSfo.sharedInstance.fire()
        expect(machine.isInState(WaitingForEntryCid.sharedInstance.getState())).to(beTrue())
        
        LatestCidIsEntryCid.sharedInstance.fire()
        expect(machine.isInState(AssociatingDriverAndVehicleAtEntry.sharedInstance.getState())).to(beTrue())
        
        DriverAndVehicleAssociated.sharedInstance.fire()
        expect(machine.isInState(VerifyingEntryGateAvi.sharedInstance.getState())).to(beTrue())
        
        EntryGateAVIReadConfirmed.sharedInstance.fire()
        expect(machine.isInState(WaitingInHoldingLot.sharedInstance.getState())).to(beTrue())
        
        // can fire DriverDispatched and make correct state change
        InsideTaxiLoopExit.sharedInstance.fire()
        expect(machine.isInState(WaitingForPaymentCid.sharedInstance.getState())).to(beTrue())
        
        LatestCidIsPaymentCid.sharedInstance.fire()
        expect(machine.isInState(AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState())).to(beTrue())

        DriverAndVehicleAssociated.sharedInstance.fire()
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
        
        // can fire TripValidated and make correct state change
        TripValidated.sharedInstance.fire()
        expect(machine.isInState(NotReady.sharedInstance.getState())).to(beTrue())
      }
    }
  }
}
