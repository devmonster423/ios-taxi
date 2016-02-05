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
      
      xit("can ping") {
        
        let tripId = 1;

        let ping = Ping(location: CLLocation(latitude: 37.615716, longitude: -122.388321),
          tripId: 123,
          vehicleId: 123,
          sessionId: 456,
          medallion: "789")
        
        self.stub(uri(Url.Trip.ping(tripId)), builder: json(TripPingMock))
        
        ApiClient.ping(tripId, ping: ping) { geofences in
          expect(geofences).toNot(beNil())
        }
      }
      
      xit("can start") {
        let tripBody = TripBody(sessionId: 123,
          medallion: "456",
          vehicleId: 789,
          smartCardId: "1234",
          deviceTimestamp: NSDate()
        )
        
        self.stub(uri(Url.Trip.start), builder: json(TripStartMock))
        ApiClient.start(tripBody) { geofences in
          expect(geofences).toNot(beNil())
        }
      }
    }
  }
}
