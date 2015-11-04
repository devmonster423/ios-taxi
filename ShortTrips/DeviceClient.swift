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
typealias AntennaClosure = AviLocation? -> Void
typealias AllCidsClosure = ([Cid]?, ErrorType?) -> Void
typealias CidClosure = CidDevice? -> Void

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
      .responseObject { (_, raw, aviResponse: AutomaticVehicleIdResponse?, _, error: ErrorType?) in

        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        
        response(aviResponse?.automaticVehicleIds, error)
    }
  }
  
  static func requestAntenna(transponderId: String, response: AntennaClosure) {
    authedRequest(Alamofire.request(.GET, Url.Device.Avi.transponder(transponderId), parameters: nil))
      .responseObject { (_, raw, antenna: Antenna?, _, error: ErrorType?) in
  
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        
        response(antenna?.device())
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
  
  static func requestCidForSmartCard(smartCardId: Int, response: CidClosure) {
    authedRequest(Alamofire.request(.GET, Url.Device.Cid.smartCard(smartCardId), parameters: nil))
      .responseObject { (_, raw, cidResponse: CidResponse?, _, error: ErrorType?) in
        
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        
        response(cidResponse?.cid.device())
    }
  }
}
