//
//  DeviceClient.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

typealias AviClosure = ([AutomaticVehicleId]?, Error?) -> Void
typealias AntennaClosure = (Antenna?) -> Void
typealias CidClosure = (Cid?) -> Void

extension ApiClient {
  static func updateMobileState(_ mobileState: MobileState, mobileStateInfo: MobileStateInfo) {
    authedRequest(.PUT, Url.Device.mobileStateUpdate(mobileState.rawValue), parameters: Mapper().toJSON(mobileStateInfo))
      .response { _, raw, _, _ in

        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        } else {
          dispatch_after(retryInterval(), dispatch_get_main_queue()) {
            updateMobileState(mobileState, mobileStateInfo: mobileStateInfo)
          }
        }
    }
  }
  
  static func requestAutomaticVehicleIds(_ response: @escaping AviClosure) {
    authedRequest(.GET, Url.Device.Avi.avi)
      .responseObject { (_, raw, aviListWrapper: AutomaticVehicleIdListWrapper?, _, error: Error?) in
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        response(aviListWrapper?.automaticVehicleIds, error)
    }
  }
  
  static func requestAntenna(_ transponderId: Int, response: @escaping AntennaClosure) {
    authedRequest(.GET, Url.Device.Avi.transponder(transponderId))
      .responseObject { (_, raw, antenna: Antenna?, _, error: Error?) in
  
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        
        if let device = antenna?.device() {
          AviManager.sharedInstance.setLatestAviLocation(device)
        }
        
        response(antenna)
    }
  }
  
  static func requestCid(_ driverId: Int, response: @escaping CidClosure) {
    authedRequest(.GET, Url.Device.Cid.driver(driverId))
      .responseObject { (_, raw, cid: Cid?, _, error: Error?) in
        
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        
        response(cid)
    }
  }
}
