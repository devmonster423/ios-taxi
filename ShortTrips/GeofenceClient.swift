//
//  GeofenceClient.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

typealias MultipleGeofencesClosure = [Geofence]? -> Void
typealias GeofenceClosure = (Geofence?, ErrorType?) -> Void

protocol GeofenceClient { }

extension ApiClient {
  static func requestAllGeofences(response: MultipleGeofencesClosure) {
    authedRequest(Alamofire.request(.GET, Url.Geofence.geofence, parameters: nil))
      .responseObject { (allGeofencesResponse: AllGeofencesResponse?, error: ErrorType?) in
      response(allGeofencesResponse?.geofenceListResponse?.geofenceList)
    }
  }
  
  static func requestGeofencesForLocation(latitude: Double, longitude: Double, buffer: Double, response: MultipleGeofencesClosure) {
    let params = ["latitude": latitude, "longitude": longitude, "buffer": buffer]
    authedRequest(Alamofire.request(.GET, Url.Geofence.locations, parameters: params))
      .responseObject { (geofenceResponse: MultipleGeofencesResponse?, error: ErrorType?) in
        response(geofenceResponse?.geofenceListWrapper?.geofenceList)
    }
  }
  
  static func requestGeofenceForLocation(longitude: Float, latitude: Float, buffer: Float, response: GeofenceClosure) {
    let params = ["longitude": longitude, "latitude": latitude, "buffer": buffer]
    authedRequest(Alamofire.request(.GET, Url.Geofence.location, parameters: params))
      .responseObject { (geofenceResponse: GeofenceResponse?, error: ErrorType?) in
      response(geofenceResponse?.geofence, error)
    }
  }
  
  static func requestGeofenceForId(id: Int, response: GeofenceClosure) {
    authedRequest(Alamofire.request(.GET, Url.Geofence.singleGeofence(id), parameters: nil))
      .responseObject { (geofenceResponse: GeofenceResponse?, error: ErrorType?) in
      response(geofenceResponse?.geofence, error)
    }
  }
}
