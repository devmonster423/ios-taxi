//
//  GeofenceResponse.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import ObjectMapper

struct AllGeofencesResponse: Mappable {
  var geofenceListResponse: GeofenceListResponse!
  
  init(geofenceListResponse: GeofenceListResponse) {
    self.geofenceListResponse = geofenceListResponse
  }

  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    geofenceListResponse <- map["response"]
  }
}
