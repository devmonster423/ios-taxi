//
//  TripInvalidation.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/22/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct TripInvalidation: Mappable {
  var deviceTimestamp: Date!
  var sessionId: Int!
  var validationStep: Int!
  
  init(validationStep: ValidationStep, sessionId: Int) {
    self.validationStep = validationStep.rawValue
    self.sessionId = sessionId
    self.deviceTimestamp = Date()
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(_ map: Map) {
    deviceTimestamp <- (map["device_timestamp"], TripDateTransform)
    sessionId <- map["session_id"]
    validationStep <- map["step"]
  }
}
