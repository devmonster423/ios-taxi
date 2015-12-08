//
//  TripScenario3Spec.swift
//  ShortTrips
//
//  Created by Joshua Adams on 11/2/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble

class TripScenario3Spec: QuickSpec {
  
  override func spec() {
    
    describe("the trip manager") {
      it("can handle scenario 3") {
        let machine = StateManager.sharedInstance.getMachine()
        
        // can be initialized
        expect(machine).toNot(beNil())
        
        // has initial state of not ready
        expect(machine.isInState(NotReady.sharedInstance.getState())).to(beTrue())
        
        InsideTaxiWaitingZone.sharedInstance.fire()
        expect(machine.isInState(WaitingForEntryCid.sharedInstance.getState())).to(beTrue())
        
        LatestCidIsEntryCid.sharedInstance.fire()
        expect(machine.isInState(AssociatingDriverAndVehicleAtEntry.sharedInstance.getState())).to(beTrue())
        
        DriverAndVehicleAssociated.sharedInstance.fire()
        expect(machine.isInState(VerifyingEntryGateAvi.sharedInstance.getState())).to(beTrue())
        
        LatestAviReadAtEntry.sharedInstance.fire()
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
        
        // can fire DriverExitsSfo and make correct state change
        ExitingTerminals.sharedInstance.fire()
        expect(machine.isInState(VerifyingExitAvi.sharedInstance.getState())).to(beTrue())
        
        LatestAviReadAtExit.sharedInstance.fire()
        expect(machine.isInState(WaitingForStartTrip.sharedInstance.getState())).to(beTrue())
        
        TripManager.sharedInstance.start(123)
        expect(machine.isInState(InProgress.sharedInstance.getState())).to(beTrue())
        
        OutsideShortTripGeofence.sharedInstance.fire()
        expect(machine.isInState(NotReady.sharedInstance.getState())).to(beTrue())
      }
    }
  }
}

