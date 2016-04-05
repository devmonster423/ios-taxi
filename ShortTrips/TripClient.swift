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

typealias SuccessClosure = Bool -> Void
typealias TripIdClosure = Int -> Void
typealias ValidationClosure = TripValidation -> Void

extension ApiClient {
  static func ping(tripId: Int, ping: Ping, response: SuccessClosure) {
    
    if PingKiller.sharedInstance.shouldKillPings() && Util.debug {
      response(false)
      return
    }
    
    authedRequest(.POST, Url.Trip.ping(tripId), parameters: Mapper().toJSON(ping))
      .response { _, raw, _, _ in
        
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
          response(StatusCode.isSuccessful(raw.statusCode))
        } else {
          response(false)
        }
    }
  }
  
  static func pings(tripId: Int, pings: PingBatch, response: SuccessClosure) {
    
    if PingKiller.sharedInstance.shouldKillPings() && Util.debug {
      response(false)
      return
    }
    
    authedRequest(.POST, Url.Trip.pings(tripId), parameters: Mapper().toJSON(pings), encoding: .JSON)
      .response { _, raw, _, _ in
        
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
          response(StatusCode.isSuccessful(raw.statusCode))
        } else {
          response(false)
        }
    }
  }
  
  static func start(tripBody: TripBody, response: TripIdClosure) {
    authedRequest(.POST, Url.Trip.start, parameters: Mapper().toJSON(tripBody))
      .responseObject { (_, raw, tripId: TripId?, _, _) in
        
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        
        if let tripId = tripId?.tripId {
          response(tripId)
        } else {
          start(tripBody, response: response)
        }
    }
  }
  
  static func end(tripId: Int, tripBody: TripBody, response: ValidationClosure) {
    authedRequest(.POST, Url.Trip.end(tripId), parameters: Mapper().toJSON(tripBody))
      .responseObject { (_, raw, validation: TripValidation?, _, _) in
        
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        
        if let validation = validation {
          response(validation)
        } else {
          end(tripId, tripBody: tripBody, response: response)
        }
    }
  }
  
  static func invalidate(tripId: Int, invalidation: ValidationStep) {
    
    PingManager.sharedInstance.sendOldPings(tripId)
    
    authedRequest(.POST, Url.Trip.invalidate(tripId), parameters: Mapper().toJSON(TripInvalidation(validationStep: invalidation)))
    .response { _, raw, _, _ in
      
      if let raw = raw {
        postNotification(SfoNotification.Request.response, value: raw)
        if !StatusCode.isSuccessful(raw.statusCode) {
          invalidate(tripId, invalidation: invalidation)
        }
      } else {
        invalidate(tripId, invalidation: invalidation)
      }
    }
  }
}
