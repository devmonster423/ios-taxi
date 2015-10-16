//
//  PollerSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/16/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import CoreLocation

class PollerSpec: QuickSpec {
  
  override func spec() {
    
    describe("the poller") {
      
      let poller = Poller.init(timeout: 60) { _ in }
      
      it("can be created") {
        expect(poller).toNot(beNil())
      }
      
      it("can be stopped") {
        poller.stop()
        expect(poller).toNot(beNil())
      }
    }
  }
}
