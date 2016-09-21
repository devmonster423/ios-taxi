//
//  GeofenceClient.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

typealias MultipleGeofencesClosure = ([SfoGeofence]?) -> Void
typealias GeofenceClosure = (Geofence?, Error?) -> Void

extension ApiClient {
  static func requestGeofencesForLocation(_ latitude: Double, longitude: Double, buffer: Double, response: @escaping MultipleGeofencesClosure) {
    let params = ["latitude": latitude, "longitude": longitude, "buffer": buffer]
    authedRequest(.GET, Url.Geofence.locations, parameters: params)
      .responseObject { (_, raw, geofenceListWrapper: GeofenceListWrapper?, _, error: Error?) in
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        response(geofenceListWrapper?.geofenceList.flatMap({ geofence -> SfoGeofence? in return geofence.geofence }))
    }
  }
}
