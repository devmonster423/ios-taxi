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
      
        // can fire DriverDispatched and make correct state change
        DriverDispatched.sharedInstance.fire(nil)
        expect(machine.isInState(Ready.sharedInstance.getState())).to(beTrue())
      }
    }
  }
}
