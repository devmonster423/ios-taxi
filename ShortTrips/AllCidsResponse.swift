//
//  AllCidsResponse.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct AllCidsResponse: Mappable {
  var cidListResponse: CidListResponse!
  
  init(cidListResponse: CidListResponse) {
    self.cidListResponse = cidListResponse
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    cidListResponse <- map["response"]
  }
}