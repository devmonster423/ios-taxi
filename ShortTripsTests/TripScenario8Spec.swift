//
//  TripScenario7Spec.swift
//  ShortTrips
//
//  Created by Joshua Adams on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble

class TripScenario8Spec: QuickSpec {
  
  override func spec() {
    
    describe("the trip manager") {
      
      beforeEach {
        if !Url.isDevUrl() {
          fatalError("can't call this when not logged in")
        }
      }
      
      it("can handle scenario 8") {
        let machine = StateManager.sharedInstance.getMachine()
        
        // can be initialized
        expect(machine).toNot(beNil())
        
        // can fire DriverDispatched and make correct state change
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
