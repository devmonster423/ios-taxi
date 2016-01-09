//
//  PingBatchSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/8/16.
//  Copyright © 2016 SFO. All rights reserved.
//

@testable import ShortTrips
import CoreLocation
import Quick
import Nimble
import Foundation
import ObjectMapper

var MockPingBatchString = "{\"session_id\":\"12345\",\"pings\":[{\"geofence_status\":0,\"session_id\":\"21008\",\"timestamp\":\"2015-12-18T23:23:48Z\",\"longitude\":-122.409925,\"latitude\":37.55517},{\"geofence_status\":0,\"session_id\":\"21008\",\"timestamp\":\"2015-12-18T23:23:48Z\",\"longitude\":-122.409925,\"latitude\":37.55517}]}"

class PingBatchSpec: QuickSpec {
  var pingBatch: PingBatch!
  
  override func spec() {
    describe("the PingBatch") {
      beforeEach {
        self.pingBatch = Mapper<PingBatch>().map(MockPingBatchString)
      }
      
      it("is non-nil") {
        expect(self.pingBatch).toNot(beNil())
      }
      
      it("is a valid pingBatch") {
        expect(self.pingBatch.pings).toNot(beNil())
        expect(self.pingBatch.sessionId).toNot(beNil())
      }
    }
  }
}
