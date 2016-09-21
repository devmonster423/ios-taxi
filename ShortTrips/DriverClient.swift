//
//  DriverClient.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import JSQNotificationObserverKit
import ObjectMapper

typealias DriverClosure = (Driver?) -> Void
typealias VehicleClosure = (Vehicle?) -> Void

extension ApiClient {
  static func authenticateDriver(_ credential: DriverCredential, completion: @escaping DriverClosure) {
    authedRequest(.POST, Url.Driver.login, parameters: Mapper().toJSON(credential))
      .responseObject { (_, raw, driver: Driver?, _, _) in
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        completion(driver)
    }
  }
  
  static func getVehicle(_ smartCard: String, completion: @escaping VehicleClosure) {
    authedRequest(.GET, Url.Driver.vehicle(smartCard))
      .responseObject { (_, raw, vehicle: Vehicle?, _, _) in
        
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        completion(vehicle)
    }
  }
}
