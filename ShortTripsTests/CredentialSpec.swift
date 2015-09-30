//
//  CredentialSpec.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/30/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

class CredentialSpec: QuickSpec {
  var credential: Credential!
  var map: Map!
  
  override func spec() {
    describe("the Credential") {
      beforeEach {
        self.credential = Credential(username: "🐅", password: "🐃")
        self.map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["key": NSString(string: "value")])
      }
      
      it("is non-nil") {
        expect(self.credential).toNot(beNil())
      }
      
      it("can map") {
        self.credential.mapping(self.map)
      }
    }
  }
}

