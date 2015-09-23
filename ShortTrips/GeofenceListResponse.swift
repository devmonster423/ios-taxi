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
  
  init(geofenceList: [Geofence]) {
    self.geofenceList = geofenceList
  }

  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    geofenceList <- map["geofence_list"]
  }
}
