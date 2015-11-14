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

//{"response":{"list":[{"id":5,"name":"trip_end_valid","displayName":null},{"id":6,"name":"trip_end_invalid","displayName":null},{"id":1,"name":"mobile_ready","displayName":null},{"id":2,"name":"mobile_not_ready","displayName":null},{"id":4,"name":"trip_in_progress","displayName":null},{"id":9,"name":"user_logged_out","displayName":null},{"id":7,"name":"mobile_no_service","displayName":null},{"id":8,"name":"mobile_crashed","displayName":null}]}}

struct MobileStateChange: Mappable {
  var longitude: Double!
  var latitude: Double!
  var tripId: Int?
  var medallion: Int!
  var mobileState: MobileState!
  var sessionId: Int!
  
  init(longitude: Double, latitude: Double, tripId: Int?, medallion: Int, mobileState: MobileState, sessionId: Int) {
    self.longitude = longitude
    self.latitude = latitude
    self.tripId = tripId
    self.medallion = medallion
    self.mobileState = mobileState
    self.sessionId = sessionId
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    longitude <- map["longitude"]
    latitude <- map["latitude"]
    tripId <- map["trip_id"]
    medallion <- map["medallion"]
    mobileState <- map["mobile_trip_state"]
    sessionId <- map["session_id"]
  }
}