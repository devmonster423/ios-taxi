//
//  ApiClientSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/25/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble

class AirlineClientSpec: QuickSpec {
  
  override func spec() {
    
    describe("the airline client") {
      it("can request codes") {
        
        waitUntil(timeout: 60) { done in
          
          ApiClient.codes({ airlines, error in
            
            expect(airlines).toNot(beNil())
            done()
          })
        }
      }
    }
  }
}
