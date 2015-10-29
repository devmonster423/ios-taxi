//
//  DeviceClientSpec.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/28/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Mockingjay

class DeviceClientSpec: QuickSpec {
  
  override func spec() {
    
    describe("the device client") {
      
      it("can post mobile state changes") {
        self.stub(uri(Url.Device.mobileState), builder: json(AllGeofenceMock))
        
        let mobileState = MobileStateChange(longitude: 10.0, latitude: 10.0, tripId: 1, tripState: TripState.Short, mobileState: MobileState.Ready, sessionId: 1)
        
        ApiClient.postMobileStateChanges(mobileState)
      }
      
      it("can request automatic vehicle ids") {
        self.stub(uri(Url.Device.Avi.avi), builder: json(RequestAutomaticVehicleIdsMock))
        
        ApiClient.requestAutomaticVehicleIds() { response, _ in
          expect(response).toNot(beNil())
        }
      }
      
      it("can request automatic vehicle ids") {
        let transponderId = "tansponder";
        self.stub(uri(Url.Device.Avi.transponder(transponderId)), builder: json(RequestAntennaMock))
        
        ApiClient.requestAntenna(transponderId) { response in
          expect(response).toNot(beNil())
        }
      }
      
      it("can request automatic vehicle ids") {
        self.stub(uri(Url.Device.Cid.cid), builder: json(RequestAllCidsMock))
        
        ApiClient.requestAllCids() { response, _ in
          expect(response).toNot(beNil())
        }
      }
      
      it("can request automatic vehicle ids") {
        let smartCardId = 5;
        self.stub(uri(Url.Device.Cid.smartCard(smartCardId)), builder: json(RequestCidForSmartCardMock))
        
        ApiClient.requestCidForSmartCard(smartCardId) { response in
          expect(response).toNot(beNil())
        }
      }
      
      
    }
  }
}


