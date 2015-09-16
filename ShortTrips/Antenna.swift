//
//  Antenna.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct Antenna: Mappable {
  var antennaId: Int!
  var aviLocation: String!
  
  static func newInstance(map: Map) -> Mappable? {
    return Antenna()
  }
  
  mutating func mapping(map: Map) {
    antennaId <- map["antenna_id"]
    aviLocation <- map["avi_location"]
  }
}