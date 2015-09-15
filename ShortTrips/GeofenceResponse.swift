//
//  GeofenceByIdResponse.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import ObjectMapper

struct GeofenceResponse: Mappable {
  var geofence: Geofence!
  
  static func newInstance(map: Map) -> Mappable? {
    return GeofenceResponse()
  }
  
  mutating func mapping(map: Map) {
    geofence <- map["response"]
  }
}
