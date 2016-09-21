//
//  ValidationStep.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

enum ValidationStep: Int {
  case unspecified = 0
  case duration = 1
  case vehicle = 2
  case driverCardId = 3
  case macAddress = 4
  case geofence = 5
  case gpsFailure = 6
  case networkFailure = 7
  case userLogout = 8
  case appQuit = 9
  case appCrash = 10
  
  func description() -> String? {
    switch self {
    case .vehicle:
      return "Vehicle miss match found (123,null)"
    case .geofence:
      return "invalid geofence"
    default:
      return nil
    }
  }
  
  func name() -> String {
    switch self {
    case .unspecified:
      return "unspecified"
    case .duration:
      return "validate_trip_duration"
    case .vehicle:
      return "validate_vehicle"
    case .driverCardId:
      return "validate_driver_card_id"
    case .macAddress:
      return "validate_mac_address"
    case .geofence:
      return "validate_geofence"
    case .gpsFailure:
      return "gps_failure_exception"
    case .networkFailure:
      return "network_failure_exception"
    case .userLogout:
      return "user_logout_exception"
    case .appQuit:
      return "app_quit_exception"
    case .appCrash:
      return "app_crash_exception"
    }
  }
}

struct ValidationStepWrapper: Mappable {
  var validationStep: ValidationStep!
  var description: String!
  var name: String!
  
  init?(_ map: Map){}
  
  init(validationStep: ValidationStep) {
    self.validationStep = validationStep
    self.description = validationStep.description()
  }
  
  mutating func mapping(_ map: Map) {
    validationStep <- map["step_id"]
    description <- map["description"]
    name <- map["step_name"]
  }
}

