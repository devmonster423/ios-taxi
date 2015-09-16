//
//  AutomaticVehicleId.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct AutomaticVehicleId: Mappable {
  var location: String!
  // Ordinarily, I like to make IDs Ints, but the sample ID given on page 15 of the
  // requirements document is "L3434", so I made id a String here.
  var id: String!
  
  static func newInstance(map: Map) -> Mappable? {
    return AutomaticVehicleId()
  }
  
  mutating func mapping(map: Map) {
    location <- map["location"]
    id <- map["id"]
  }
}