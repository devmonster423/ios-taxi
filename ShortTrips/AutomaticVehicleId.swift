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
  var id: String!
  
  init(location: String, id: String) {
    self.location = location
    self.id = id
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    location <- map["location"]
    id <- map["id"]
  }
}