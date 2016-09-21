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
  case ready = 1
  case notReady = 2
  case inProgress = 4
  case valid = 5
  case invalid = 6
  case noService = 7
  case crashed = 8
  case loggedOut = 9
  
  func name() -> String {
    switch self {
    case .valid:
      return "trip_end_valid"
    case .invalid:
      return "trip_end_invalid"
    case .ready:
      return "mobile_ready"
    case .notReady:
      return "mobile_not_ready"
    case .inProgress:
      return "trip_in_progress"
    case .loggedOut:
      return "user_logged_out"
    case .noService:
      return "mobile_no_service"
    case .crashed:
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
  
  mutating func mapping(_ map: Map) {
    longitude <- map["longitude"]
    latitude <- map["latitude"]
    sessionId <- map["session_id"]
    tripId <- map["trip_id"]
  }
}
