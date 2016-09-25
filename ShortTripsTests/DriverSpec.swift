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
  
  override func spec() {
    describe("the Driver") {
      beforeEach {
        self.driver = Mapper<Driver>().map(JSONString: MockDriverString)
      }
      
      it("is non-nil") {
        expect(self.driver).toNot(beNil())
      }
      
      it("is a valid driver") {
        expect(self.driver.sessionId).toNot(beNil())
        expect(self.driver.driverId).toNot(beNil())
        expect(self.driver.cardId).toNot(beNil())
        expect(self.driver.firstName).toNot(beNil())
        expect(self.driver.lastName).toNot(beNil())
        expect(self.driver.driverLicense).toNot(beNil())
      }
    }
  }
}
