//
//  DispatcherClientSpec.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/28/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Mockingjay

class DispatcherClientSpec: QuickSpec {
  
  override func spec() {
    
    describe("the displatcher client") {
      it("can request lot status") {
        
        self.stub(uri(Url.Dispatcher.holdingLotCapacity), builder: json(LotStatusMock))
        
        ApiClient.requestLotStatus() { response, _ in
          expect(response).toNot(beNil())
        }
        
      }
    }
    
  }
}