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
  var transponderId: String!
  
  init(vehicleId: Int, transponderId: String) {
    self.vehicleId = vehicleId
    self.transponderId = transponderId
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    vehicleId <- map["response.vehicle_id"]
    transponderId <- map["response.transponder_id"]
  }
}
