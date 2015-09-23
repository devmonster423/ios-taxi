//
//  SfoInfoRequester.swift
//  ShortTrips
//
//  Created by Josh Adams on 8/13/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire

struct ApiClient: DeviceClient, DispatcherClient, DriverClient, FlightClient, GeofenceClient, ImageClient, ReferenceClient {
  
  private static let sfoUsername = "taxi_short@staging"
  private static let sfoPassword = "mvUh6tYEwU9nYDrQ"
  
  static func authedRequest(request: Request) -> Request {
    return request.authenticate(user: sfoUsername, password: sfoPassword, persistence: .Permanent)
  }
}
