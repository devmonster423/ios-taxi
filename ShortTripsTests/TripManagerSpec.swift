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

class TripManagerSpec: QuickSpec {
  
  override func spec() {
    
    describe("the trip manager") {
      it("can initialize") {
        expect(TripManager.sharedInstance.getMachine()).toNot(beNil())
      }
    }
  }
}
