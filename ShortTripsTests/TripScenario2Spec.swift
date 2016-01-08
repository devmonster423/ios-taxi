//
//  TripScenarioSpec2.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/30/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble

class TripScenario2Spec: QuickSpec {
  
  override func spec() {
    
    describe("the trip manager") {
      it("can handle scenario 2") {
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
        expect(machine.isInState(WaitingForEntryAvi.sharedInstance.getState())).to(beTrue())
        
        LatestAviAtEntry.sharedInstance.fire()
        expect(machine.isInState(WaitingInHoldingLot.sharedInstance.getState())).to(beTrue())
        
        InsideTaxiLoopExit.sharedInstance.fire()
        expect(machine.isInState(WaitingForPaymentCid.sharedInstance.getState())).to(beTrue())
        
        LatestCidIsPaymentCid.sharedInstance.fire()
        expect(machine.isInState(AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState())).to(beTrue())

        DriverAndVehicleAssociated.sharedInstance.fire()
        expect(machine.isInState(WaitingForTaxiLoopAvi.sharedInstance.getState())).to(beTrue())
        
        LatestAviAtTaxiLoop.sharedInstance.fire()
        expect(machine.isInState(Ready.sharedInstance.getState())).to(beTrue())
        
        OutsideSfo.sharedInstance.fire()
        expect(machine.isInState(WaitingForStartTrip.sharedInstance.getState())).to(beTrue())
        
        TripManager.sharedInstance.start(123)
        expect(machine.isInState(InProgress.sharedInstance.getState())).to(beTrue())
        
        TimeExpired.sharedInstance.fire()
        expect(machine.isInState(NotReady.sharedInstance.getState())).to(beTrue())
      }
      
      it("can handle scenario 2 even inside SFO") {
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
        expect(machine.isInState(WaitingForEntryAvi.sharedInstance.getState())).to(beTrue())
        
        LatestAviAtEntry.sharedInstance.fire()
        expect(machine.isInState(WaitingInHoldingLot.sharedInstance.getState())).to(beTrue())
        
        InsideTaxiLoopExit.sharedInstance.fire()
        expect(machine.isInState(WaitingForPaymentCid.sharedInstance.getState())).to(beTrue())
        
        LatestCidIsPaymentCid.sharedInstance.fire()
        expect(machine.isInState(AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState())).to(beTrue())
        
        DriverAndVehicleAssociated.sharedInstance.fire()
        expect(machine.isInState(WaitingForTaxiLoopAvi.sharedInstance.getState())).to(beTrue())
        
        LatestAviAtTaxiLoop.sharedInstance.fire()
        expect(machine.isInState(Ready.sharedInstance.getState())).to(beTrue())
        
        // can fire DriverExitsSfo and make correct state change
        ExitingTerminals.sharedInstance.fire()
        expect(machine.isInState(WaitingForExitAvi.sharedInstance.getState())).to(beTrue())
        
        LatestAviAtDomExit.sharedInstance.fire()
        expect(machine.isInState(WaitingForStartTrip.sharedInstance.getState())).to(beTrue())
        
        TripManager.sharedInstance.start(123)
        expect(machine.isInState(InProgress.sharedInstance.getState())).to(beTrue())
        
        InsideSfo.sharedInstance.fire()
        expect(machine.isInState(WaitingForReEntryAvi.sharedInstance.getState())).to(beTrue())
        
        TimeExpired.sharedInstance.fire()
        expect(machine.isInState(NotReady.sharedInstance.getState())).to(beTrue())
      }
    }
  }
}

