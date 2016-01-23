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
  var deviceTimestamp: NSDate!
  var validationStep: Int!
  
  init(validationStep: ValidationStep) {
    self.validationStep = validationStep.rawValue
    self.deviceTimestamp = NSDate()
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    deviceTimestamp <- (map["device_timestamp"], TripDateTransform)
    validationStep <- map["step"]
  }
}
