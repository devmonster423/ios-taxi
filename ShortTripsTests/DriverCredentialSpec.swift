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

class DriverCredentialSpec: QuickSpec {
  var credential: DriverCredential!
  
  override func spec() {
    describe("the Credential") {
      beforeEach {
        self.credential = DriverCredential(username: "username", password: "password")
      }
      
      it("is non-nil") {
        expect(self.credential).toNot(beNil())
      }
      
      it("can map") {
        expect(self.credential.toJSON()).toNot(beNil())
      }
    }
  }
}

