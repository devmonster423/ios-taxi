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
      
      beforeEach {
        if !Url.isDevUrl() {
          fatalError("can't call this when not logged in")
        }
      }
      
      it("can handle scenario 4 with a logout") {
        let machine = StateManager.sharedInstance.getMachine()
        expect(machine).toNot(beNil())
        expect(machine.is(inState: NotReady.sharedInstance.getState())).to(beTrue())
        InsideTaxiWaitingZone.sharedInstance.fire()
        expect(machine.is(inState: WaitingForEntryCid.sharedInstance.getState())).to(beTrue())
        LatestCidIsEntryCid.sharedInstance.fire()
        expect(machine.is(inState: AssociatingDriverAndVehicleAtEntry.sharedInstance.getState())).to(beTrue())
        DriverAndVehicleAssociated.sharedInstance.fire()
        expect(machine.is(inState: WaitingForEntryAvi.sharedInstance.getState())).to(beTrue())
        LatestAviAtEntry.sharedInstance.fire()
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
        TripStarted.sharedInstance.fire()
        expect(machine.is(inState: InProgress.sharedInstance.getState())).to(beTrue())
        OutsideShortTripGeofence.sharedInstance.fire()
        expect(machine.is(inState: NotReady.sharedInstance.getState())).to(beTrue())
        LoggedOut.sharedInstance.fire()
        expect(machine.is(inState: NotReady.sharedInstance.getState())).to(beTrue())
        
        // Follow Scenario 1 happy path.
        expect(machine).toNot(beNil())
        expect(machine.is(inState: NotReady.sharedInstance.getState())).to(beTrue())
        InsideTaxiWaitingZone.sharedInstance.fire()
        expect(machine.is(inState: WaitingForEntryCid.sharedInstance.getState())).to(beTrue())
        LatestCidIsEntryCid.sharedInstance.fire()
        expect(machine.is(inState: AssociatingDriverAndVehicleAtEntry.sharedInstance.getState())).to(beTrue())
        DriverAndVehicleAssociated.sharedInstance.fire()
        expect(machine.is(inState: WaitingForEntryAvi.sharedInstance.getState())).to(beTrue())
        LatestAviAtEntry.sharedInstance.fire()
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
        
        LatestCidIsReEntryCid.sharedInstance.fire()
        expect(machine.is(inState: AssociatingDriverAndVehicleAtReEntry.sharedInstance.getState())).to(beTrue())
        
        DriverAndVehicleAssociated.sharedInstance.fire()
        expect(machine.is(inState: WaitingForReEntryAvi.sharedInstance.getState())).to(beTrue())
        
        LatestAviAtReEntry.sharedInstance.fire()
        expect(machine.is(inState: ValidatingTrip.sharedInstance.getState())).to(beTrue())
        
        TripValidated.sharedInstance.fire()
        expect(machine.is(inState: WaitingInHoldingLot.sharedInstance.getState())).to(beTrue())
      }
      
      it("can handle scenario 4 with an app quit") {
        let machine = StateManager.sharedInstance.getMachine()
        expect(machine).toNot(beNil())
        Failure.sharedInstance.fire()
        expect(machine.is(inState: NotReady.sharedInstance.getState())).to(beTrue())
        InsideTaxiWaitingZone.sharedInstance.fire()
        expect(machine.is(inState: WaitingForEntryCid.sharedInstance.getState())).to(beTrue())
        LatestCidIsEntryCid.sharedInstance.fire()
        expect(machine.is(inState: AssociatingDriverAndVehicleAtEntry.sharedInstance.getState())).to(beTrue())
        DriverAndVehicleAssociated.sharedInstance.fire()
        expect(machine.is(inState: WaitingForEntryAvi.sharedInstance.getState())).to(beTrue())
        LatestAviAtEntry.sharedInstance.fire()
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
        TripStarted.sharedInstance.fire()
        expect(machine.is(inState: InProgress.sharedInstance.getState())).to(beTrue())
        OutsideShortTripGeofence.sharedInstance.fire()
        expect(machine.is(inState: NotReady.sharedInstance.getState())).to(beTrue())
        AppQuit.sharedInstance.fire()
        expect(machine.is(inState: NotReady.sharedInstance.getState())).to(beTrue())
        
        // Follow Scenario 1 happy path.
        expect(machine).toNot(beNil())
        expect(machine.is(inState: NotReady.sharedInstance.getState())).to(beTrue())
        InsideTaxiWaitingZone.sharedInstance.fire()
        expect(machine.is(inState: WaitingForEntryCid.sharedInstance.getState())).to(beTrue())
        LatestCidIsEntryCid.sharedInstance.fire()
        expect(machine.is(inState: AssociatingDriverAndVehicleAtEntry.sharedInstance.getState())).to(beTrue())
        DriverAndVehicleAssociated.sharedInstance.fire()
        expect(machine.is(inState: WaitingForEntryAvi.sharedInstance.getState())).to(beTrue())
        LatestAviAtEntry.sharedInstance.fire()
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
        
        LatestCidIsReEntryCid.sharedInstance.fire()
        expect(machine.is(inState: AssociatingDriverAndVehicleAtReEntry.sharedInstance.getState())).to(beTrue())
        
        DriverAndVehicleAssociated.sharedInstance.fire()
        expect(machine.is(inState: WaitingForReEntryAvi.sharedInstance.getState())).to(beTrue())
        
        LatestAviAtReEntry.sharedInstance.fire()
        expect(machine.is(inState: ValidatingTrip.sharedInstance.getState())).to(beTrue())
        
        TripValidated.sharedInstance.fire()
        expect(machine.is(inState: WaitingInHoldingLot.sharedInstance.getState())).to(beTrue())
      }
    }
  }
}

