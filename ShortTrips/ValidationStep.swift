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
  case VehicleMismatch = 2
  case InvalidGeofence = 5
  
  func description() -> String {
    switch self {
    case .VehicleMismatch:
      return "Vehicle miss match found (1404,null)"
    case .InvalidGeofence:
      return "invalid geofence"
    }
  }
  
  func name() -> String {
    switch self {
    case .VehicleMismatch:
      return "vehicle"
    case .InvalidGeofence:
      return "geofence"
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

