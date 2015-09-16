//
//  AntennaResponse.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct AntennaResponse: Mappable {
  var antenna: Antenna!
  
  init() {}
  
  static func newInstance(map: Map) -> Mappable? {
    return AntennaResponse()
  }
  
  mutating func mapping(map: Map) {
    antenna <- map["response"]
  }
}