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
  var geofence: SfoGeofence?
  
  init(status: GeofenceStatus, geofence: SfoGeofence?) {
    self.status = status
    self.geofence = geofence
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    status <- map["response.geofence_status"]
    geofence <- map["response.geofence_id"]
  }
}
