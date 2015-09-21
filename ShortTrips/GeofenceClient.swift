//
//  GeofenceRequester.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

typealias AllGeofencesClosure = ([Geofence]?, ErrorType?) -> Void
typealias GeofenceClosure = (Geofence?, ErrorType?) -> Void

protocol GeofenceClient {
  static func requestAllGeofences(response: AllGeofencesClosure)
  static func requestGeofenceForLocation(longitude: Float, latitude: Float, buffer: Float, response: GeofenceClosure)
  static func requestGeofenceForId(id: Int, response: GeofenceClosure)
}

extension ApiClient {
  static func requestAllGeofences(response: AllGeofencesClosure) {
    Alamofire.request(.GET, Url.Geofence.geofence, parameters: nil).responseObject { (allGeofencesResponse: AllGeofencesResponse?, error: ErrorType?) in
      response(allGeofencesResponse?.geofenceListResponse?.geofenceList, error)
    }
  }
  
  static func requestGeofenceForLocation(longitude: Float, latitude: Float, buffer: Float, response: GeofenceClosure) {
    let params = ["longitude": longitude, "latitude": latitude, "buffer": buffer]
    Alamofire.request(.GET, Url.Geofence.location, parameters: params).responseObject { (geofenceResponse: GeofenceResponse?, error: ErrorType?) in
      response(geofenceResponse?.geofence, error)
    }
  }
  
  static func requestGeofenceForId(id: Int, response: GeofenceClosure) {
    Alamofire.request(.GET, Url.Geofence.singleGeofence(id), parameters: nil).responseObject { (geofenceResponse: GeofenceResponse?, error: ErrorType?) in
      response(geofenceResponse?.geofence, error)
    }
  }
}
