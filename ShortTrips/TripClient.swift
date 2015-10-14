//
//  TripClient.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

typealias GeofenceStatusClosure = Bool? -> Void

protocol TripClient { }

extension ApiClient {
  static func ping(tripId: Int, ping: Ping, response: GeofenceStatusClosure) {
    authedRequest(Alamofire.request(.POST, Url.Trip.ping(tripId), parameters: Mapper().toJSON(ping)))
      .responseObject { (geofenceStatus: GeofenceStatus?, error: ErrorType?) in
        response(geofenceStatus?.status)
    }
  }
}

