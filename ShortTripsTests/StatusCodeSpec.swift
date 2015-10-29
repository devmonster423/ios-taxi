//
//  StatusCodeSpec.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/29/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

import Quick
import Nimble

class StatusCodeSpec: QuickSpec {
  
  override func spec() {
    
    describe("the status code") {
      
      it("can tell if successful") {
        //expect(StatusCode.isSuccessful(200)).to(beTruthy())
      }

      it("can tell if not successful") {
        //expect(StatusCode.isSuccessful(500)).toNot(beTruthy())
      }
      
    }
  }
}