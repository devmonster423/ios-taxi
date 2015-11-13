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
typealias TripIdClosure = Int? -> Void
typealias ValidationClosure = Bool? -> Void

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
  
  static func start(sessionId: Int, response: TripIdClosure) {
    authedRequest(Alamofire.request(.POST, Url.Trip.start, parameters: ["session_id": sessionId]))
      .responseObject { (_, raw, tripId: TripId?, _, _) in
        
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        response(tripId?.tripId)
    }
  }
  
  static func end(tripId: Int, response: ValidationClosure) {
    authedRequest(Alamofire.request(.POST, Url.Trip.end(tripId), parameters: nil ))
      .responseObject { (_, raw, validation: TripValidation?, _, _) in
        
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        
        response(validation?.valid)
    }
  }
  
  static func invalidate(tripId: Int, validation: ValidationStepWrapper) {
    authedRequest(Alamofire.request(.POST, Url.Trip.invalidate(tripId), parameters: Mapper().toJSON(validation)))
    .response { _, raw, _, _ in
      
      if let raw = raw {
        postNotification(SfoNotification.Request.response, value: raw)
      }
    }
  }
}
