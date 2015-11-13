//
//  TripClientSpec.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/28/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import CoreLocation
import Quick
import Nimble
import Mockingjay

class TripClientSpec: QuickSpec {
  
  override func spec() {
    
    describe("the trip client") {
      
      it("can ping") {
        
        let tripId = 1;

        let ping = Ping( location: CLLocation.init())
        
        self.stub(uri(Url.Trip.ping(tripId)), builder: json(TripPingMock))
        
        ApiClient.ping(tripId, ping: ping) { geofences in
          expect(geofences).toNot(beNil())
        }
      }
      
      it("can start") {
        let tripBody = TripBody(sessionId: 123, medallion: 456)
        
        self.stub(uri(Url.Trip.start), builder: json(TripStartMock))
        ApiClient.start(tripBody) { geofences in
          expect(geofences).toNot(beNil())
        }
      }
    }
  }
}
