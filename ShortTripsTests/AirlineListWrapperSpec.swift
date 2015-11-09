//
//  AirlineListWrapperSpec.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/29/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

class AirlineListWrapperSpec: QuickSpec {
  var airlineListWrapper: AirlineListWrapper!
  var map: Map!
  
  override func spec() {
    describe("the AirlineListWrapper") {
      beforeEach {
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["airlines": ["airline" : NSString(string: "EX123"), "airlineName": NSString(string: "ExygyAirline")]] )
        self.airlineListWrapper = AirlineListWrapper(self.map)
        print("&&& airlines: \(self.airlineListWrapper.airlines) &&&")
      }
      
      it("is non-nil") {
        expect(self.airlineListWrapper).toNot(beNil())
      }
      
      it("can map") {
        expect(self.airlineListWrapper.mapping(self.map)).toNot(beNil())
      }
    }
  }
}