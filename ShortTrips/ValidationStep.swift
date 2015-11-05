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
  case InvalidGeofence = 5
  
  func description() -> String {
    switch self {
    case .InvalidGeofence:
      return "invalid geofence"
    }
  }
}

struct ValidationStepWrapper: Mappable {
  var validationStep: ValidationStep!
  var description: String?
  
  init?(_ map: Map){}
  
  init(validationStep: ValidationStep) {
    self.validationStep = validationStep
    self.description = validationStep.description()
  }
  
  mutating func mapping(map: Map) {
    validationStep <- map["step"]
    description <- map["description"]
  }
}

