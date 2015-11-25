//
//  MobileStateChange.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

enum MobileState: Int {
  case Ready = 1
  case NotReady = 2
  case InProgress = 4
  case Valid = 5
  case Invalid = 6
  case NoService = 7
  case Crashed = 8
  case LoggedOut = 9
  
  func name() -> String {
    switch self {
    case Valid:
      return "trip_end_valid"
    case Invalid:
      return "trip_end_invalid"
    case Ready:
      return "mobile_ready"
    case NotReady:
      return "mobile_not_ready"
    case InProgress:
      return "trip_in_progress"
    case LoggedOut:
      return "user_logged_out"
    case NoService:
      return "mobile_no_service"
    case Crashed:
      return "mobile_crashed"
    }
  }
}

struct MobileStateInfo: Mappable {
  var longitude: Double!
  var latitude: Double!
  var sessionId: Int!
  var tripId: Int?
  
  init(longitude: Double, latitude: Double, sessionId: Int, tripId: Int? = nil) {
    self.longitude = longitude
    self.latitude = latitude
    self.sessionId = sessionId
    self.tripId = tripId
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    longitude <- map["longitude"]
    latitude <- map["latitude"]
    sessionId <- map["session_id"]
    tripId <- map["trip_id"]
  }
}