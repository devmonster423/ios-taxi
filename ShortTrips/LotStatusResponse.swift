//
//  LotStatusResponse.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/13/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

enum LotStatus: String {
  case Yes = "yes"
  case No = "no"
  case Maybe = "maybe"
}

struct LotStatusResponse: Mappable {
  var lotStatus: LotStatus?
  
  static func newInstance(map: Map) -> Mappable? {
    return LotStatusResponse()
  }
  
  mutating func mapping(map: Map) {
    lotStatus <- map["lotStatus"]
  }
}