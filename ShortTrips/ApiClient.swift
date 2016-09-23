//
//  ApiClient.swift
//  ShortTrips
//
//  Created by Josh Adams on 8/13/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation

struct ApiClient {
  
  static func retryInterval() -> DispatchTime {
    return DispatchTime.now() + Double(Int64(5.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
  }
  
  // "taxi_short@sfo", "mvUh6tYEwU9nYDrQ"
  private static let auth = "Basic dGF4aV9zaG9ydEBzZm86bXZVaDZ0WUV3VTluWURyUQ=="
  
  static func headers() -> [String: String]? {
    var headers = [String: String]()
    
    headers["Authorization"] = auth
    
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
