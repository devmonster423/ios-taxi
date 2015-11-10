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
import JSQNotificationObserverKit

typealias AviClosure = ([AutomaticVehicleId]?, ErrorType?) -> Void
typealias AntennaClosure = Antenna? -> Void
typealias AllCidsClosure = ([Cid]?, ErrorType?) -> Void
typealias GtmsLocationClosure = GtmsLocation? -> Void

protocol DeviceClient { }

extension ApiClient {
  static func postMobileStateChanges(mobileStateChange: MobileStateChange) {
    authedRequest(Alamofire.request(.POST, Url.Device.mobileState, parameters: Mapper().toJSON(mobileStateChange), encoding: .JSON))
      .response { _, raw, _, error in

        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        
        print(error)
    }
  }
  
  static func requestAutomaticVehicleIds(response: AviClosure) {
    authedRequest(Alamofire.request(.GET, Url.Device.Avi.avi, parameters: nil))
      .responseObject { (_, raw, aviListWrapper: AutomaticVehicleIdListWrapper?, _, error: ErrorType?) in
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        response(aviListWrapper?.automaticVehicleIds, error)
    }
  }
  
  static func requestAntenna(transponderId: Int, response: AntennaClosure) {
    authedRequest(Alamofire.request(.GET, Url.Device.Avi.transponder(transponderId), parameters: nil))
      .responseObject { (_, raw, antenna: Antenna?, _, error: ErrorType?) in
  
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        
        response(antenna)
    }
  }
  
  
  static func requestAllCids(response: AllCidsClosure) {
    authedRequest(Alamofire.request(.GET, Url.Device.Cid.cid, parameters: nil))
      .responseObject { (_, raw, allCidsResponse: AllCidsResponse?, _, error: ErrorType?) in

        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
  
        response(allCidsResponse?.cidListResponse?.cidList, error)
    }
  }
  
  static func requestCid(driverId: Int, response: GtmsLocationClosure) {
    authedRequest(Alamofire.request(.GET, Url.Device.Cid.driver(driverId), parameters: nil))
      .responseObject { (_, raw, cidResponse: CidResponse?, _, error: ErrorType?) in
        
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        
        response(cidResponse?.cid.device())
    }
  }
}
