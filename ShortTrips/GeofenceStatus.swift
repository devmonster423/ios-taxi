//
//  GeofenceStatus.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct GeofenceStatus: Mappable {
  var status: Bool!
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    status <- map["geofence_status"]
  }
}
