//
//  AutomaticVehicleIdResponse.swift
//  ShortTrips
//
//  Created by Joshua Adams and 🐈 on 9/18/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct AutomaticVehicleIdResponse: Mappable {
  var automaticVehicleIds: [AutomaticVehicleId]!
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    automaticVehicleIds <- map["response"]
  }
}