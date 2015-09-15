//
//  DriverResponse.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct DriverResponse: Mappable {
  var driver: Driver!
  
  init() {}
  
  static func newInstance(map: Map) -> Mappable? {
    return DriverResponse()
  }
  
  mutating func mapping(map: Map) {
    driver <- map["driver"]
  }
}