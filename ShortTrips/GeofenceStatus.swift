//
//  GeofenceStatus.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct FoundGeofenceStatus: Mappable {
  var status: GeofenceStatus!
  var geofenceId: Int?
  
  init(status: GeofenceStatus, geofenceId: Int?) {
    self.status = status
    self.geofenceId = geofenceId
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    status <- map["response.geofence_status"]
    geofenceId <- map["response.geofence_id"]
  }
}
