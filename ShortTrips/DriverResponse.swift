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
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    driver <- map["driver"]
  }
}