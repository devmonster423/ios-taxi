//
//  TripClient.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import JSQNotificationObserverKit
import ObjectMapper

typealias GeofenceStatusClosure = Bool? -> Void

protocol TripClient { }

extension ApiClient {
  static func ping(tripId: Int, ping: Ping, response: GeofenceStatusClosure) {
    authedRequest(Alamofire.request(.POST, Url.Trip.ping(tripId), parameters: Mapper().toJSON(ping)))
      .responseObject { (_, raw, geofenceStatus: GeofenceStatus?, _, _) in
        
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }

        response(geofenceStatus?.status)
    }
  }
}

