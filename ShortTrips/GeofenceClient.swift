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
import JSQNotificationObserverKit

typealias MultipleGeofencesClosure = [Geofence]? -> Void
typealias GeofenceClosure = (Geofence?, ErrorType?) -> Void

extension ApiClient {
  static func requestGeofencesForLocation(latitude: Double, longitude: Double, buffer: Double, response: MultipleGeofencesClosure) {
    let params = ["latitude": latitude, "longitude": longitude, "buffer": buffer]
    authedRequest(.GET, Url.Geofence.locations, parameters: params)
      .responseObject { (_, raw, geofenceListWrapper: GeofenceListWrapper?, _, error: ErrorType?) in
        if let raw = raw {
          postNotification(SfoNotification.Request.response, value: raw)
        }
        response(geofenceListWrapper?.geofenceList)
    }
  }
}
