//
//  DeviceClient.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

typealias AviClosure = ([AutomaticVehicleId]?, Error?) -> Void
typealias AntennaClosure = (Antenna?) -> Void
typealias CidClosure = (Cid?) -> Void

extension ApiClient {
  
  static func updateMobileState(_ mobileState: MobileState, mobileStateInfo: MobileStateInfo, retryCount: Int = 0) {
    
    if lastKnownRemoteState == mobileState {
      return
    }
    
    Alamofire.request(Url.Device.mobileStateUpdate(mobileState.rawValue), method: .put, parameters: Mapper().toJSON(mobileStateInfo), headers: headers())
      .response { dataResponse in
        
        if let raw = dataResponse.response {
          NotificationCenter.default.post(name: .response, object: nil, userInfo: [InfoKey.response: raw])
          lastKnownRemoteState = mobileState
          
        } else if retryCount < maxRetries {
          DispatchQueue.main.asyncAfter(deadline: retryInterval(retryCount)) {
            updateMobileState(mobileState, mobileStateInfo: mobileStateInfo, retryCount: retryCount + 1)
          }
        }
    }
  }
  
  static func requestAntenna(_ transponderId: Int, response: @escaping AntennaClosure) {
    Alamofire.request(Url.Device.Avi.transponder(transponderId), headers: headers())
      .responseObject { (dataResponse: DataResponse<Antenna>) in
  
        if let raw = dataResponse.response {
          NotificationCenter.default.post(name: .response, object: nil, userInfo: [InfoKey.response: raw])
        }
        
        if let device = dataResponse.result.value?.device() {
          AviManager.sharedInstance.setLatestAviLocation(device)
        }
        
        response(dataResponse.result.value)
    }
  }
  
  static func requestCid(_ driverId: Int, response: @escaping CidClosure) {
    Alamofire.request(Url.Device.Cid.driver(driverId), headers: headers())
      .responseObject { (dataResponse: DataResponse<Cid>) in
        
        if let raw = dataResponse.response {
          NotificationCenter.default.post(name: .response, object: nil, userInfo: [InfoKey.response: raw])
        }
        
        response(dataResponse.result.value)
    }
  }
}
