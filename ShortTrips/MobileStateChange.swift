//
//  MobileStateChange.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

enum MobileState: String {
  case Null = "NULL"
  case NotReady = "NOT READY"
  case Ready = "READY"
  case InProgress = "IN PROGRESS"
  case Validating = "VALIDATING"
  case Valid = "VALID"
}

struct MobileStateChange: Mappable {
  var longitude: Float!
  var latitude: Float!
  var tripId: Int!
  var tripState: TripState!
  var mobileState: MobileState!
  var sessionId: Int!
  
  init(longitude: Float, latitude: Float, tripId: Int, tripState: TripState, mobileState: MobileState, sessionId: Int) {
    self.longitude = longitude
    self.latitude = latitude
    self.tripId = tripId
    self.tripState = tripState
    self.mobileState = mobileState
    self.sessionId = sessionId
  }
  
  init() {}
  
  static func newInstance(map: Map) -> Mappable? {
    return MobileStateChange()
  }
  
  mutating func mapping(map: Map) {
    longitude <- map["longitude"]
    latitude <- map["latitude"]
    tripId <- map["trip_id"]
    tripState <- map["trip_state"]
    mobileState <- map["mobile_state"]
    sessionId <- map["session_id"]
  }
}