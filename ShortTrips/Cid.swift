//
//  Cid.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct Cid: Mappable {
  var cidId: Int!
  var cidLocation: String!

  init(cidId: Int, cidLocation: String) {
    self.cidId = cidId
    self.cidLocation = cidLocation
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    cidId <- map["cid_id"]
    cidLocation <- map["cid_location"]
  }
}