//
//  TripClient.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import JSQNotificationObserverKit
import ObjectMapper

typealias GeofenceStatusClosure = FoundGeofenceStatus? -> Void
typealias TripIdClosure = Int? -> Void
typealias ValidationClosure = TripValidation? -> Void

extension ApiClient {
  static func ping(tripId: Int, ping: Ping, response: GeofenceStatusClosure) {
    authedRequest(.POST, Url.Trip.ping(tripId), parameters: Mapper().toJSON(ping))
      .responseObject { (_, raw, geofenceStatus: FoundGeofenceStatus?, _, _) in
        
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }

        response(geofenceStatus)
    }
  }
  
  static func pings(tripId: Int, pings: PingBatch, response: GeofenceStatusClosure) {
    authedRequest(.POST, Url.Trip.pings(tripId), parameters: Mapper().toJSON(PingBatchWrapper(pings)))
      .response { _, raw, _, _ in
        
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
    }
  }
  
  static func start(tripBody: TripBody, response: TripIdClosure) {
    authedRequest(.POST, Url.Trip.start, parameters: Mapper().toJSON(tripBody))
      .responseObject { (_, raw, tripId: TripId?, _, _) in
        
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        response(tripId?.tripId)
    }
  }
  
  static func end(tripId: Int, tripBody: TripBody, response: ValidationClosure) {
    authedRequest(.POST, Url.Trip.end(tripId), parameters: Mapper().toJSON(tripBody))
      .responseObject { (_, raw, validation: TripValidation?, _, _) in
        
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        
        response(validation)
    }
  }
  
  static func invalidate(tripId: Int, validation: ValidationStep) {
    authedRequest(.POST, Url.Trip.invalidate(tripId), parameters: ["step": "\(validation.rawValue)"])
    .response { _, raw, _, _ in
      
      if let raw = raw {
        postNotification(SfoNotification.Request.response, value: raw)
      }
    }
  }
}
