//
//  PendingAppQuitSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 8/25/16.
//  Copyright © 2016 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation

class PendingAppQuitSpec: QuickSpec {
  
  override func spec() {
    describe("a PendingAppQuit") {
      it("can be set and gotten") {
        let fakeTripId = 99
        PendingAppQuit.set(fakeTripId)
        expect(PendingAppQuit.get()) == fakeTripId
      }
    }
  }
}
