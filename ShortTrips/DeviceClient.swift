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
import JSQNotificationObserverKit

typealias AviClosure = ([AutomaticVehicleId]?, ErrorType?) -> Void
typealias AntennaClosure = Antenna? -> Void
typealias AllCidsClosure = ([Cid]?, ErrorType?) -> Void
typealias GtmsLocationClosure = GtmsLocation? -> Void

protocol DeviceClient { }

extension ApiClient {
  static func updateMobileState(mobileState: MobileState, mobileStateInfo: MobileStateInfo) {
    authedRequest(.PUT, Url.Device.mobileStateUpdate(mobileState.rawValue), parameters: Mapper().toJSON(mobileStateInfo))
      .response { _, raw, _, _ in

        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
    }
  }
  
  static func requestAutomaticVehicleIds(response: AviClosure) {
    authedRequest(.GET, Url.Device.Avi.avi)
      .responseObject { (_, raw, aviListWrapper: AutomaticVehicleIdListWrapper?, _, error: ErrorType?) in
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        response(aviListWrapper?.automaticVehicleIds, error)
    }
  }
  
  static func requestAntenna(transponderId: Int, response: AntennaClosure) {
    authedRequest(.GET, Url.Device.Avi.transponder(transponderId))
      .responseObject { (_, raw, antenna: Antenna?, _, error: ErrorType?) in
  
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        
        response(antenna)
    }
  }
  
  static func requestAllCids(response: AllCidsClosure) {
    authedRequest(.GET, Url.Device.Cid.cid)
      .responseObject { (_, raw, cidListWrapper: CidListWrapper?, _, error: ErrorType?) in

        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
  
        response(cidListWrapper?.cidList, error)
    }
  }
  
  static func requestCid(driverId: Int, response: GtmsLocationClosure) {
    authedRequest(.GET, Url.Device.Cid.driver(driverId))
      .responseObject { (_, raw, cid: Cid?, _, error: ErrorType?) in
        
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        
        response(cid?.device())
    }
  }
}
