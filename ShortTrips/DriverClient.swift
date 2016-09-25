//
//  DriverClient.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

typealias DriverClosure = (Driver?) -> Void
typealias VehicleClosure = (Vehicle?) -> Void

extension ApiClient {
  static func authenticateDriver(_ credential: DriverCredential, completion: @escaping DriverClosure) {
    Alamofire.request(Url.Driver.login, method: .post, parameters: Mapper().toJSON(credential), headers: headers())
      .responseObject { (dataResponse: DataResponse<Driver>) in
        if let raw = dataResponse.response {
          NotificationCenter.default.post(name: .response, object: nil, userInfo: [InfoKey.response: raw])
        }
        completion(dataResponse.result.value)
    }
  }
  
  static func getVehicle(_ smartCard: String, completion: @escaping VehicleClosure) {
    Alamofire.request(Url.Driver.vehicle(smartCard), headers: headers())
      .responseObject { (dataResponse: DataResponse<Vehicle>) in
        
        if let raw = dataResponse.response {
          NotificationCenter.default.post(name: .response, object: nil, userInfo: [InfoKey.response: raw])
        }
        completion(dataResponse.result.value)
    }
  }
}
