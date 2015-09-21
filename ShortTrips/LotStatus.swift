//
//  LotStatus.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/18/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import ObjectMapper

struct LotStatus: Mappable {
  var lotStatusEnum: LotStatusEnum!
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    lotStatusEnum <- map["lot_status"]
  }
}


