//
//  TripFallbackSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/11/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble

class TripFallbackSpec: QuickSpec {
  
  override func spec() {
    
    describe("the trip manager") {
      
      beforeEach {
        if !Url.isDevUrl() {
          fatalError("can't call this when not logged in")
        }
      }
      
      it("can fallback from entry") {
        let machine = StateManager.sharedInstance.getMachine()
        
        // can be initialized
        expect(machine).toNot(beNil())
        
        Failure.sharedInstance.fire()
        // has initial state of not ready
        expect(machine.is(inState: NotReady.sharedInstance.getState())).to(beTrue())
        
        InsideTaxiWaitingZone.sharedInstance.fire()
        expect(machine.is(inState: WaitingForEntryCid.sharedInstance.getState())).to(beTrue())
        
        NotInsideTaxiWaitZoneAfterFailedEntryCheck.sharedInstance.fire()
        expect(machine.is(inState: NotReady.sharedInstance.getState())).to(beTrue())
        
        InsideTaxiWaitingZone.sharedInstance.fire()
        expect(machine.is(inState: WaitingForEntryCid.sharedInstance.getState())).to(beTrue())

        LatestCidIsEntryCid.sharedInstance.fire()
        expect(machine.is(inState: AssociatingDriverAndVehicleAtEntry.sharedInstance.getState())).to(beTrue())
        
        NotInsideTaxiWaitZoneAfterFailedEntryCheck.sharedInstance.fire()
        expect(machine.is(inState: NotReady.sharedInstance.getState())).to(beTrue())
       
        InsideTaxiWaitingZone.sharedInstance.fire()
        expect(machine.is(inState: WaitingForEntryCid.sharedInstance.getState())).to(beTrue())
        
        LatestCidIsEntryCid.sharedInstance.fire()
        expect(machine.is(inState: AssociatingDriverAndVehicleAtEntry.sharedInstance.getState())).to(beTrue())
        
        DriverAndVehicleAssociated.sharedInstance.fire()
        expect(machine.is(inState: WaitingForEntryAvi.sharedInstance.getState())).to(beTrue())
        
        NotInsideTaxiWaitZoneAfterFailedEntryCheck.sharedInstance.fire()
        expect(machine.is(inState: NotReady.sharedInstance.getState())).to(beTrue())
      }
      
      it("can fallback from payment to not ready") {
        let machine = StateManager.sharedInstance.getMachine()
        
        // can be initialized
        expect(machine).toNot(beNil())
        
        // has initial state of not ready
        expect(machine.is(inState: NotReady.sharedInstance.getState())).to(beTrue())
        
        InsideTaxiLoopExit.sharedInstance.fire()
        expect(machine.is(inState: WaitingForPaymentCid.sharedInstance.getState())).to(beTrue())
        
        NotInTaxiLoopOrInHoldingLotAfterFailedPaymentCheck.sharedInstance.fire()
        expect(machine.is(inState: NotReady.sharedInstance.getState())).to(beTrue())
      }
      
      it("can fallback from payment to waiting in holding lot") {
        let machine = StateManager.sharedInstance.getMachine()
        
        // can be initialized
        expect(machine).toNot(beNil())
        
        // has initial state of not ready
        expect(machine.is(inState: NotReady.sharedInstance.getState())).to(beTrue())
        
        InsideTaxiWaitingZone.sharedInstance.fire()
        expect(machine.is(inState: WaitingForEntryCid.sharedInstance.getState())).to(beTrue())
        
        LatestCidIsEntryCid.sharedInstance.fire()
        expect(machine.is(inState: AssociatingDriverAndVehicleAtEntry.sharedInstance.getState())).to(beTrue())
        
        DriverAndVehicleAssociated.sharedInstance.fire()
        expect(machine.is(inState: WaitingForEntryAvi.sharedInstance.getState())).to(beTrue())
        
        AviManager.sharedInstance.setLatestAviLocation(.TaxiEntry)
        LatestAviAtEntry.sharedInstance.fire()
        expect(machine.is(inState: WaitingInHoldingLot.sharedInstance.getState())).to(beTrue())
        
        AviManager.sharedInstance.setLatestAviLocation(.TaxiStatus)
        InsideTaxiLoopExit.sharedInstance.fire()
        expect(machine.is(inState: WaitingForPaymentCid.sharedInstance.getState())).to(beTrue())
        
        NotInTaxiLoopOrInHoldingLotAfterFailedPaymentCheck.sharedInstance.fire()
        expect(machine.is(inState: WaitingInHoldingLot.sharedInstance.getState())).to(beTrue())
        
        InsideTaxiLoopExit.sharedInstance.fire()
        expect(machine.is(inState: WaitingForPaymentCid.sharedInstance.getState())).to(beTrue())
        
        LatestCidIsPaymentCid.sharedInstance.fire()
        expect(machine.is(inState: AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState())).to(beTrue())
        
        NotInTaxiLoopOrInHoldingLotAfterFailedPaymentCheck.sharedInstance.fire()
        expect(machine.is(inState: WaitingInHoldingLot.sharedInstance.getState())).to(beTrue())
        
        InsideTaxiLoopExit.sharedInstance.fire()
        expect(machine.is(inState: WaitingForPaymentCid.sharedInstance.getState())).to(beTrue())
        
        LatestCidIsPaymentCid.sharedInstance.fire()
        expect(machine.is(inState: AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState())).to(beTrue())
        
        DriverAndVehicleAssociated.sharedInstance.fire()
        expect(machine.is(inState: WaitingForTaxiLoopAvi.sharedInstance.getState())).to(beTrue())
        
        NotInTaxiLoopOrInHoldingLotAfterFailedPaymentCheck.sharedInstance.fire()
        expect(machine.is(inState: WaitingInHoldingLot.sharedInstance.getState())).to(beTrue())
      }
      
      it("can fallback from re-entry") {
        let machine = StateManager.sharedInstance.getMachine()
        
        // can be initialized
        expect(machine).toNot(beNil())
        
        expect(machine.is(inState: WaitingInHoldingLot.sharedInstance.getState())).to(beTrue())
        
        InsideTaxiLoopExit.sharedInstance.fire()
        expect(machine.is(inState: WaitingForPaymentCid.sharedInstance.getState())).to(beTrue())
        
        LatestCidIsPaymentCid.sharedInstance.fire()
        expect(machine.is(inState: AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState())).to(beTrue())
        
        DriverAndVehicleAssociated.sharedInstance.fire()
        expect(machine.is(inState: WaitingForTaxiLoopAvi.sharedInstance.getState())).to(beTrue())
        
        LatestAviAtTaxiLoop.sharedInstance.fire()
        expect(machine.is(inState: Ready.sharedInstance.getState())).to(beTrue())
        
        OutsideBufferedExit.sharedInstance.fire()
        expect(machine.is(inState: WaitingForExitAvi.sharedInstance.getState())).to(beTrue())
        
        ExitAviCheckComplete.sharedInstance.fire()
        expect(machine.is(inState: StartingTrip.sharedInstance.getState())).to(beTrue())
        
        TripManager.sharedInstance.start(123)
        expect(machine.is(inState: InProgress.sharedInstance.getState())).to(beTrue())
        
        InsideBufferedExit.sharedInstance.fire()
        expect(machine.is(inState: WaitingForReEntryCid.sharedInstance.getState())).to(beTrue())
        
        NotInsideSfoAfterFailedReEntryCheck.sharedInstance.fire()
        expect(machine.is(inState: InProgress.sharedInstance.getState())).to(beTrue())
        
        InsideBufferedExit.sharedInstance.fire()
        expect(machine.is(inState: WaitingForReEntryCid.sharedInstance.getState())).to(beTrue())
        
        LatestCidIsReEntryCid.sharedInstance.fire()
        expect(machine.is(inState: AssociatingDriverAndVehicleAtReEntry.sharedInstance.getState())).to(beTrue())
        
        NotInsideSfoAfterFailedReEntryCheck.sharedInstance.fire()
        expect(machine.is(inState: InProgress.sharedInstance.getState())).to(beTrue())
        
        InsideBufferedExit.sharedInstance.fire()
        expect(machine.is(inState: WaitingForReEntryCid.sharedInstance.getState())).to(beTrue())
        
        LatestCidIsReEntryCid.sharedInstance.fire()
        expect(machine.is(inState: AssociatingDriverAndVehicleAtReEntry.sharedInstance.getState())).to(beTrue())
        
        DriverAndVehicleAssociated.sharedInstance.fire()
        expect(machine.is(inState: WaitingForReEntryAvi.sharedInstance.getState())).to(beTrue())
        
        NotInsideSfoAfterFailedReEntryCheck.sharedInstance.fire()
        expect(machine.is(inState: InProgress.sharedInstance.getState())).to(beTrue())
        
        Failure.sharedInstance.fire()
        expect(machine.is(inState: NotReady.sharedInstance.getState())).to(beTrue())
      }
    }
  }
}
