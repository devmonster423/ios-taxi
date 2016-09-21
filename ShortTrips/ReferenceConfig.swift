//
//  ReferenceConfig.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/14/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct ReferenceConfig: Mappable {
  var pingInterval: Int!
  var tripDuration: Int!
  var gisBuffer: Float!
    
  init?(_ map: Map){}
  
  init(pingInterval: Int, tripDuration: Int, gisBuffer: Float) {
    self.pingInterval = pingInterval
    self.tripDuration = tripDuration
    self.gisBuffer = gisBuffer
  }
  
  mutating func mapping(_ map: Map) {
    pingInterval <- map["response.ping_interval"]
    tripDuration <- map["response.trip_duration"]
    gisBuffer <- map["response.gis_buffer"]
  }
}
