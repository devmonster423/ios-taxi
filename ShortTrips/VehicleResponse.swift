//
//  VehicleResponse.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/16/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct VehicleResponse: Mappable {
  var vehicle: Vehicle!
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    vehicle <- map["response"]
  }
}
