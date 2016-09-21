//
//  GeofenceListWrapper.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import ObjectMapper

struct GeofenceListWrapper: Mappable {
  var geofenceList: [Geofence]!
  
  init(geofenceList: [Geofence]) {
    self.geofenceList = geofenceList
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(_ map: Map) {
    geofenceList <- map["response.geofences"]
  }
}
