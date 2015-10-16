//
//  Vehicle.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/16/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct Vehicle: Mappable {
  var vehicleId: Int!
  
  init(vehicleId: Int) {
    self.vehicleId = vehicleId
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    vehicleId <- map["vehicle_id"]
  }
}
