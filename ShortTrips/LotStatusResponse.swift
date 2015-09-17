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
  
  static func random() -> LotStatus {
    switch arc4random_uniform(3) {
    case 0:
      return .Yes
    case 1:
      return .Maybe
    default:
      return .No
    }
  }
}

struct LotStatusResponse: Mappable {
  var lotStatus: LotStatus!
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    lotStatus <- map["lotStatus"]
  }
}