//
//  TripValidation.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/30/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct TripValidation: Mappable {
  var valid: Bool!
  var validationSteps: [ValidationStepWrapper]?
  
  init?(map: Map){}
  
  init(valid: Bool, validationSteps: [ValidationStepWrapper]? = nil) {
    self.valid = valid
    self.validationSteps = validationSteps
  }
  
  mutating func mapping(map: Map) {
    valid <- map["response.trip_valid"]
    validationSteps <- map["response.validation_steps"]
  }
}
