//
//  DriverResponseSpec.swift
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

class DriverResponseSpec: QuickSpec {
  var driver: Driver!
  var driverResponse: DriverResponse!
  var map: Map!
  
  override func spec() {
    describe("the DriverResponse") {
      beforeEach {
        self.driver = Driver(sessionId: 42, driverId: 42, cardId: 42, firstName: "🐴", lastName: "🐑")
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
        self.driverResponse = DriverResponse(self.map)
        self.driverResponse.driver = self.driver
      }
      
      it("is non-nil") {
        expect(self.driverResponse).toNot(beNil())
      }
      
      it("has a Driver") {
        expect(self.driver).toNot(beNil())
      }
      
      it("can map") {
        self.driverResponse.mapping(self.map)
      }
    }
  }
}
