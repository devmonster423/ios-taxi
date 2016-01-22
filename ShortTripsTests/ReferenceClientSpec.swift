//
//  ReferenceClientSpec.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/28/15.
//  Copyright © 2015 SFO. All rights reserved.
//


@testable import ShortTrips
import Quick
import Nimble
import Mockingjay

class ReferenceClientSpec: QuickSpec {
  
  override func spec() {
    
    describe("the reference client") {
      
      xit("can request reference config") {
        
        self.stub(uri(Url.Reference.config), builder: json(RequestReferenceConfigMock))
        
        ApiClient.requestReferenceConfig { geofences, _ in
          expect(geofences).toNot(beNil())
        }
      }
      
    }
  }
}