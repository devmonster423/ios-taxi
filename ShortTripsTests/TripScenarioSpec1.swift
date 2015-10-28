//
//  TripManagerSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/5/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble

class TripScenarioSpec1: QuickSpec {
  
  override func spec() {
    
    describe("the trip manager") {
      it("can handle scenario 1") {
        let machine = TripManager.sharedInstance.getMachine()

        // can be initialized
        expect(machine).toNot(beNil())
        
        // has initial state of not ready
        expect(machine.isInState(NotReady.sharedInstance.getState())).to(beTrue())
      
        EnteredSFOGeofence.sharedInstance.fire()
        expect(machine.isInState(WaitingForEntryCID.sharedInstance.getState())).to(beTrue())
        
        LatestCidIsEntryCid.sharedInstance.fire()
        expect(machine.isInState(AssociatingDriverAndVehicle.sharedInstance.getState())).to(beTrue())
        
        DriverAndVehicleAssociated.sharedInstance.fire()
        expect(machine.isInState(VerifyingEntryGateAVI.sharedInstance.getState())).to(beTrue())
        
        EntryGateAVIReadConfirmed.sharedInstance.fire()
        expect(machine.isInState(WaitingInHoldingLot.sharedInstance.getState())).to(beTrue())
        
        // can fire DriverDispatched and make correct state change
        InsideTaxiLoopExit.sharedInstance.fire()
        expect(machine.isInState(WaitingForPaymentCID.sharedInstance.getState())).to(beTrue())
        
        LatestCidIsPaymentCid.sharedInstance.fire()
        expect(machine.isInState(VerifyingTaxiLoopAVI.sharedInstance.getState())).to(beTrue())
        
        LatestAviReadAtTaxiLoop.sharedInstance.fire()
        expect(machine.isInState(Ready.sharedInstance.getState())).to(beTrue())
        
        // can fire DriverExitsSfo and make correct state change
        DriverExitsSfo.sharedInstance.fire()
        expect(machine.isInState(InProgress.sharedInstance.getState())).to(beTrue())
        
        // can fire DriverReturnsToSfo and make correct state change
        DriverReturnsToSfo.sharedInstance.fire()
        expect(machine.isInState(Validating.sharedInstance.getState())).to(beTrue())
        
        // can fire TripValidated and make correct state change
        TripValidated.sharedInstance.fire()
        expect(machine.isInState(Valid.sharedInstance.getState())).to(beTrue())
        
        // can fire DriverProceedsToTaxiLoop and make correct state change
        DriverProceedsToTaxiLoop.sharedInstance.fire()
        expect(machine.isInState(Ready.sharedInstance.getState())).to(beTrue())
      }
    }
  }
}
