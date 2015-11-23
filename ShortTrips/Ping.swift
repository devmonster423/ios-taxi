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

enum GeofenceStatus: Int {
  case Invalid = 0
  case Valid = 1
  
  func toBool() -> Bool {
    switch self {
    case .Invalid:
      return false
    case .Valid:
      return true
    }
  }
}

struct Ping: Mappable {
  var latitude: Double!
  var longitude: Double!
  var timestamp: NSDate!
  var tripId: Int!
  var sessionId: Int!
  var medallion: Int!
  var geofenceStatus: GeofenceStatus!
  
  static let transform = DateTransform(dateFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'") // 2015-09-15T16:13:48Z
  
  init?(_ map: Map){}
  
  init(location: CLLocation, tripId: Int, sessionId: Int, medallion: Int) {
    self.latitude = location.coordinate.latitude
    self.longitude = location.coordinate.longitude
    self.timestamp = location.timestamp
    self.tripId = tripId
    self.sessionId = sessionId
    self.medallion = medallion
    
    // TODO: actually determine locally
    self.geofenceStatus = .Invalid
  }
  
  mutating func mapping(map: Map) {
    tripId <- map["trip_id"]
    sessionId <- map["session_id"]
    medallion <- map["medallion"]
    latitude <- map["latitude"]
    longitude <- map["longitude"]
    timestamp <- (map["timestamp"], Ping.transform)
    geofenceStatus <- map["geofence_status"]
  }
}
