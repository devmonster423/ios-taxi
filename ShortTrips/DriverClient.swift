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

typealias DriverClosure = (DriverCredential, Driver?) -> Void
typealias VehicleClosure = Vehicle? -> Void

protocol DriverClient { }

extension ApiClient {
  static func authenticateDriver(credential: DriverCredential, completion: DriverClosure) {
    authedRequest(.POST, Url.Driver.login, parameters: Mapper().toJSON(credential))
      .responseObject { (_, raw, driver: Driver?, _, _) in
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        completion(credential, driver)
    }
  }
  
  static func getVehicle(smartCard: String, completion: VehicleClosure) {
    authedRequest(.GET, Url.Driver.vehicle(smartCard))
      .responseObject { (_, raw, vehicle: Vehicle?, _, _) in
        
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        completion(vehicle)
    }
  }
}
