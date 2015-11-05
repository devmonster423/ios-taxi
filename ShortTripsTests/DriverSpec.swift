//
//  DriverSpec.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/22/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

class DriverSpec: QuickSpec {
  var driver: Driver!
  var map: Map!
  
  override func spec() {
    describe("the Driver") {
      beforeEach {
        self.driver = Driver(sessionId: 42, driverId: 42, cardId: 42, firstName: "🐷", lastName: "🐮", driverLicense: "3F0-3xy6y")
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
      }
      
      it("is non-nil") {
        expect(self.driver).toNot(beNil())
      }
      
      it("can map") {
        self.driver.mapping(self.map)
      }
    }
  }
}
