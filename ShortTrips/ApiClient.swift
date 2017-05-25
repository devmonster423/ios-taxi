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
  
  private static let headerApiKey = "apikey"
  private static let stagingApiKey = "Se2wwq4oWy5pxBrqLdsilBXDnscRGZrJ"
  
  static var lastKnownRemoteState: MobileState?
  
  static let maxRetries = 10
  static func retryInterval(_ retryCount: Int) -> DispatchTime {
    return DispatchTime.now() + Double(Int64(Double(retryCount + 1) * 5.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
  }
    
  static func headers() -> [String: String]? {
    var headers = [String: String]()
    
    headers[headerApiKey] = stagingApiKey
    
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
