//
//  LotStatusResponse.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/13/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct LotStatusResponse: Mappable {
  var lotStatus: LotStatus!
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    lotStatus <- map["response"]
  }
}