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
  case notVerified = -1
  case invalid = 0
  case valid = 1
  
  func toBool() -> Bool {
    switch self {
    case .valid:
      return true
    default:
      return false
    }
  }
  
  static func fromBool(_ bool: Bool) -> GeofenceStatus {
    return bool ? .valid : .invalid
  }
}

struct Ping: Mappable {
  var latitude: Double!
  var longitude: Double!
  var timestamp: Date!
  var tripId: Int!
  var sessionId: Int!
  var medallion: String?
  var vehicleId: Int!
  var geofenceStatus: GeofenceStatus!
  
  init?(map: Map){}
  
  init(location: CLLocation, tripId: Int, vehicleId: Int, sessionId: Int, medallion: String?) {
    self.latitude = location.coordinate.latitude
    self.longitude = location.coordinate.longitude
    self.timestamp = location.timestamp
    self.tripId = tripId
    self.sessionId = sessionId
    self.medallion = medallion
    self.vehicleId = vehicleId
    self.geofenceStatus = GeofenceStatus.fromBool(GeofenceArbiter.checkLocation(location.coordinate))
  }
  
  mutating func mapping(map: Map) {
    tripId <- map["trip_id"]
    sessionId <- map["session_id"]
    medallion <- map["medallion"]
    vehicleId <- map["vehicle_id"]
    latitude <- map["latitude"]
    longitude <- map["longitude"]
    timestamp <- (map["timestamp"], TripDateTransform)
    geofenceStatus <- map["geofence_status"]
  }
}
