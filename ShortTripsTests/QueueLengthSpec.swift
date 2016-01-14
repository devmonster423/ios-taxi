//
//  QueueSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/13/16.
//  Copyright © 2016 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

var MockQueueLengthString = "{\"response\":{\"long_queue_length\":318,\"short_queue_length\":7}}"

class QueueLengthSpec: QuickSpec {
  var queueLength: QueueLength!
  
  override func spec() {
    describe("the QueueLength") {
      beforeEach {
        self.queueLength = Mapper<QueueLength>().map(MockQueueLengthString)
      }
      
      it("is non-nil") {
        expect(self.queueLength).toNot(beNil())
      }
    }
  }
}
