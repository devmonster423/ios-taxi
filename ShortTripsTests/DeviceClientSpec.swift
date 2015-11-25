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
//        self.stub(uri(Url.Device.mobileStateUpdate(MobileState.Ready.rawValue)), builder: json(AllGeofenceMock))
        
        let mobileState = MobileStateInfo(longitude: 10.0, latitude: 10.0, sessionId: 1, tripId: 1)
        
        ApiClient.updateMobileState(MobileState.Ready, mobileStateInfo: mobileState)
      }
      
      it("can request automatic vehicle ids") {
        self.stub(uri(Url.Device.Avi.avi), builder: json(RequestAutomaticVehicleIdsMock))
        
        ApiClient.requestAutomaticVehicleIds() { response, _ in
          expect(response).toNot(beNil())
        }
      }
      
      it("can request automatic vehicle ids") {
        let transponderId = 2005887;
        self.stub(uri(Url.Device.Avi.transponder(transponderId)), builder: json(RequestAntennaMock))
        
        ApiClient.requestAntenna(transponderId) { response in
          expect(response).toNot(beNil())
        }
      }
      
      it("can request automatic vehicle ids") {
        let driverId = 5;
        self.stub(uri(Url.Device.Cid.driver(driverId)), builder: json(RequestCidForSmartCardMock))
        
        ApiClient.requestCid(driverId) { response in
          expect(response).toNot(beNil())
        }
      }
    }
  }
}
