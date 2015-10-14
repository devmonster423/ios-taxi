//
//  Ping.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import CoreLocation
import ObjectMapper

struct Ping: Mappable {
  var latitude: Double!
  var longitude: Double!
  var timestamp: NSDate!
  var geofenceStatus: Bool!
  
  init?(_ map: Map){}
  
  init(location: CLLocation) {
    self.latitude = location.coordinate.latitude
    self.longitude = location.coordinate.longitude
    self.timestamp = location.timestamp
    
    // TODO: actually determine locally
    self.geofenceStatus = false
  }
  
  mutating func mapping(map: Map) {
    latitude <- map["latitude"]
    longitude <- map["longitude"]
    timestamp <- map["timestamp"]
    geofenceStatus <- map["geofence_status"]
  }
}
