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
  case Unspecified = 0
  case Duration = 1
  case Vehicle = 2
  case DriverCardId = 3
  case MacAddress = 4
  case Geofence = 5
  case GpsFailure = 6
  case NetworkFailure = 7
  case UserLogout = 8
  case AppQuit = 9
  case AppCrash = 10
  
  func description() -> String? {
    switch self {
    case .Vehicle:
      return "Vehicle miss match found (123,null)"
    case .Geofence:
      return "invalid geofence"
    default:
      return nil
    }
  }
  
  func name() -> String {
    switch self {
    case .Unspecified:
      return "unspecified"
    case .Duration:
      return "validate_trip_duration"
    case .Vehicle:
      return "validate_vehicle"
    case .DriverCardId:
      return "validate_driver_card_id"
    case .MacAddress:
      return "validate_mac_address"
    case .Geofence:
      return "validate_geofence"
    case .GpsFailure:
      return "gps_failure_exception"
    case .NetworkFailure:
      return "network_failure_exception"
    case .UserLogout:
      return "user_logout_exception"
    case .AppQuit:
      return "app_quit_exception"
    case .AppCrash:
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
  
  mutating func mapping(map: Map) {
    validationStep <- map["step_id"]
    description <- map["description"]
    name <- map["step_name"]
  }
}

