//
//  DeviceRequester.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

typealias AviClosure = ([AutomaticVehicleId]?, ErrorType?) -> Void
typealias AntennaClosure = (Antenna?, ErrorType?) -> Void
typealias AllCidsClosure = ([Cid]?, ErrorType?) -> Void
typealias CidForSmartCardClosure = (Cid?, ErrorType?) -> Void

protocol DeviceClient {
  static func postMobileStateChanges(mobileStateChange: MobileStateChange)
  static func requestAutomaticVehicleIds(response: AviClosure)
  static func requestAntenna(transponderId: Int, response: AntennaClosure)
  static func requestAllCids(response: AllCidsClosure)
  static func requestCidForSmartCard(smartCardId: Int, response: CidForSmartCardClosure)
}

extension ApiClient {
  static func postMobileStateChanges(mobileStateChange: MobileStateChange) {
    authedRequest(Alamofire.request(.POST, Url.Device.mobileState, parameters: Mapper().toJSON(mobileStateChange), encoding: .JSON))
      .response { _, _, _, error in
      print(error)
    }
  }
  
  static func requestAutomaticVehicleIds(response: AviClosure) {
    authedRequest(Alamofire.request(.GET, Url.Device.Avi.avi, parameters: nil))
      .responseObject { (aviResponse: AutomaticVehicleIdResponse?, error: ErrorType?) in
      response(aviResponse?.automaticVehicleIds, error)
    }
  }
  
  static func requestAntenna(transponderId: Int, response: AntennaClosure) {
    authedRequest(Alamofire.request(.GET, Url.Device.Avi.transponder(transponderId), parameters: nil))
      .responseObject { (antennaResponse: AntennaResponse?, error: ErrorType?) in
      response(antennaResponse?.antenna, error)
    }
  }
  
  static func requestAllCids(response: AllCidsClosure) {
    authedRequest(Alamofire.request(.GET, Url.Device.Cid.cid, parameters: nil))
      .responseObject { (allCidsResponse: AllCidsResponse?, error: ErrorType?) in
      response(allCidsResponse?.cidListResponse?.cidList, error)
    }
  }
  
  static func requestCidForSmartCard(smartCardId: Int, response: CidForSmartCardClosure) {
    authedRequest(Alamofire.request(.GET, Url.Device.Cid.smartCard(smartCardId), parameters: nil))
      .responseObject { (cidResponse: CidResponse?, error: ErrorType?) in
      response(cidResponse?.cid, error)
    }
  }
}
