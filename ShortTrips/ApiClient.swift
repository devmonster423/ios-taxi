//
//  ApiClient.swift
//  ShortTrips
//
//  Created by Josh Adams on 8/13/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire

struct ApiClient {
  
  private static let sfoUsername = "taxi_short@staging"
  private static let sfoPassword = "mvUh6tYEwU9nYDrQ"
  
  static func authedRequest(
    method: Alamofire.Method,
    _ URLString: URLStringConvertible,
    parameters: [String: AnyObject]? = nil)
    -> Request
  {
    let request = Alamofire.request(method, URLString, parameters: parameters, encoding: .URL, headers: headers())
    return request.authenticate(user: sfoUsername, password: sfoPassword, persistence: .Permanent)
  }
  
  static func headers() -> [String: String]? {
    var headers = [String: String]()
    
    if let driverId = DriverManager.sharedInstance.getCurrentDriver()?.driverId {
      headers["driver"] = "\(driverId)"
    }
    
    if let medallion = DriverManager.sharedInstance.getCurrentVehicle()?.medallion {
      headers["medallion"] = "\(medallion)"
    }
    
    if let vehicleId = DriverManager.sharedInstance.getCurrentVehicle()?.vehicleId {
      headers["vehicle_id"] = "\(vehicleId)"
    }
    
    return headers
  }
}
