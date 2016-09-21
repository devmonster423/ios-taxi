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
  
  static func retryInterval() -> DispatchTime {
    return DispatchTime.now() + Double(Int64(5.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
  }
  
  fileprivate static let sfoUsername = "taxi_short@sfo"
  fileprivate static let sfoPassword = "mvUh6tYEwU9nYDrQ"
  
  static func authedRequest(
    _ method: Alamofire.Method,
    _ URLString: URLStringConvertible,
    parameters: [String: AnyObject]? = nil,
    encoding: ParameterEncoding = .URL)
    -> Request
  {
    let request = Alamofire.request(method, URLString, parameters: parameters, encoding: encoding, headers: headers())
    return request // request.authenticate(user: sfoUsername, password: sfoPassword, persistence: .Permanent)
  }
  
  static func headers() -> [String: String]? {
    var headers = [String: String]()
    
    headers["Authorization"] = "Basic dGF4aV9zaG9ydEBzZm86bXZVaDZ0WUV3VTluWURyUQ=="
    
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
