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
import ObjectMapper

typealias SuccessClosure = (Bool) -> Void
typealias TripIdClosure = (Int) -> Void
typealias ValidationClosure = (TripValidation) -> Void

extension ApiClient {
  
  static func ping(_ tripId: Int, ping: Ping, response: @escaping SuccessClosure) {
    
    if PingKiller.sharedInstance.shouldKillPings() && Util.debug {
      response(false)
      return
    }
    
    Alamofire.request(Url.Trip.ping(tripId), method: .post, parameters: ping.toJSON() as [String: AnyObject], headers: headers())
      .response { defaultDataResponse in
      
        if let raw = defaultDataResponse.response {
          NotificationCenter.default.post(name: .response, object: nil, userInfo: [InfoKey.response: raw])
          response(StatusCode.isSuccessful(raw.statusCode))
        } else {
          response(false)
        }
    }
  }
  
  static func pings(_ tripId: Int, pings: PingBatch, response: @escaping SuccessClosure) {
    
    if PingKiller.sharedInstance.shouldKillPings() && Util.debug {
      response(false)
      return
    }
    
    Alamofire.request(Url.Trip.pings(tripId), method: .post, parameters: pings.toJSON() as [String : AnyObject], encoding: JSONEncoding.default, headers: headers())
      .response { defaultDataResponse in
        
        if let raw = defaultDataResponse.response {
          NotificationCenter.default.post(name: .response, object: nil, userInfo: [InfoKey.response: raw])
          response(StatusCode.isSuccessful(raw.statusCode))
        } else {
          response(false)
        }
    }
  }
  
  static func start(_ tripBody: TripBody, retryCount: Int = 0, response: @escaping TripIdClosure) {
    Alamofire.request(Url.Trip.start, method: .post, parameters: Mapper().toJSON(tripBody), headers: headers())
      .responseObject { (dataResponse: DataResponse<TripId>) in
        
        if let raw = dataResponse.response {
          NotificationCenter.default.post(name: .response, object: nil, userInfo: [InfoKey.response: raw])
        }
        
        if let tripId = dataResponse.result.value?.tripId {
          response(tripId)
          
        } else if retryCount < maxRetries {
          DispatchQueue.main.asyncAfter(deadline: retryInterval(retryCount)) {
            start(tripBody, retryCount: retryCount + 1, response: response)
          }
          
        } else {
          Failure.sharedInstance.fire()
        }
    }
  }
  
  static func end(_ tripId: Int, tripBody: TripBody, retryCount: Int = 0, response: @escaping ValidationClosure) {
    Alamofire.request(Url.Trip.end(tripId), method: .post, parameters: Mapper().toJSON(tripBody), headers: headers())
      .responseObject { (dataResponse: DataResponse<TripValidation>) in
        
        if let raw = dataResponse.response {
          NotificationCenter.default.post(name: .response, object: nil, userInfo: [InfoKey.response: raw])
        }
        
        if let validation = dataResponse.result.value {
          response(validation)
          
        } else if retryCount < maxRetries {
          DispatchQueue.main.asyncAfter(deadline: retryInterval(retryCount)) {
            end(tripId, tripBody: tripBody, retryCount: retryCount + 1, response: response)
          }
          
        } else {
          let validation = TripValidation(valid: false)
          response(validation)
        }
    }
  }
  
  static func invalidate(_ tripId: Int, invalidation: ValidationStep, retryCount: Int = 0, sessionId: Int) {
    
    PingManager.sharedInstance.sendOldPings(tripId)
    
    Alamofire.request(Url.Trip.invalidate(tripId), method: .post, parameters: Mapper().toJSON(TripInvalidation(validationStep: invalidation, sessionId: sessionId)), headers: headers())
    .response { defaultDataResponse in
      
      if let raw = defaultDataResponse.response {
        NotificationCenter.default.post(name: .response, object: nil, userInfo: [InfoKey.response: raw])
        
        if StatusCode.isSuccessful(raw.statusCode) {
          PendingAppQuit.set(nil)
          
        } else if retryCount < maxRetries {
          DispatchQueue.main.asyncAfter(deadline: retryInterval(retryCount)) {
            invalidate(tripId, invalidation: invalidation, retryCount: retryCount + 1, sessionId: sessionId)
          }
        }
      } else if retryCount < maxRetries {
        DispatchQueue.main.asyncAfter(deadline: retryInterval(retryCount)) {
          invalidate(tripId, invalidation: invalidation, retryCount: retryCount + 1, sessionId: sessionId)
        }
      }
    }
  }
}
