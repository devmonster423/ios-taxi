//
//  AirlineClientSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/19/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Mockingjay

class AirlineClientSpec: QuickSpec {
  
  override func spec() {
    
    describe("the airline client") {
      
      beforeEach {
        if !Url.isDevUrl() {
          fatalError("can't call this when not logged in")
        }
      }
      
      xit("can request codes") {
        
        self.stub(uri(Url.Airline.codes), builder: json(IataCodeMock))        
        ApiClient.codes { airlines, error in
          expect(airlines).toNot(beNil())
        }
      }
    }
  }
}