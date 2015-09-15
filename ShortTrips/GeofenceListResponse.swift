//
//  GeofenceResponse.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import ObjectMapper

struct GeofenceListResponse: Mappable {
  var geofenceList: [Geofence]!
  
  static func newInstance(map: Map) -> Mappable? {
    return GeofenceListResponse()
  }
  
  mutating func mapping(map: Map) {
    geofenceList <- map["geofence_list"]
  }
}
