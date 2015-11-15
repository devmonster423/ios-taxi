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

typealias GeofenceStatusClosure = FoundGeofenceStatus? -> Void
typealias TripIdClosure = Int? -> Void
typealias ValidationClosure = TripValidation? -> Void

protocol TripClient { }

extension ApiClient {
  static func ping(tripId: Int, ping: Ping, response: GeofenceStatusClosure) {
    authedRequest(Alamofire.request(.POST, Url.Trip.ping(tripId), parameters: Mapper().toJSON(ping)))
      .responseObject { (_, raw, geofenceStatus: FoundGeofenceStatus?, _, _) in
        
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }

        response(geofenceStatus)
    }
  }
  
  static func start(tripBody: TripBody, response: TripIdClosure) {
    // TODO: also add header as per discussion: https://basecamp.com/1759841/projects/9992902/messages/51037813#comment_354637715
    authedRequest(Alamofire.request(.POST, Url.Trip.start, parameters: Mapper().toJSON(tripBody)))
      .responseObject { (_, raw, tripId: TripId?, _, _) in
        
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        response(tripId?.tripId)
    }
  }
  
  static func end(tripId: Int, medallion: Int, response: ValidationClosure) {
    // TODO: also add header as per discussion: https://basecamp.com/1759841/projects/9992902/messages/51037813#comment_354637715
    authedRequest(Alamofire.request(.POST, Url.Trip.end(tripId), parameters: ["medallion": medallion]))
      .responseObject { (_, raw, validation: TripValidation?, _, _) in
        
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        
        response(validation)
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
