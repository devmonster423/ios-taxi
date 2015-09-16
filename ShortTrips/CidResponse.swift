//
//  CidResponse.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct CidResponse: Mappable {
  var cid: Cid!
  
  static func newInstance(map: Map) -> Mappable? {
    return CidResponse()
  }
  
  mutating func mapping(map: Map) {
    cid <- map["response"]
  }
}
