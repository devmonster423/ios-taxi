//
//  CidListWrapper.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct CidListWrapper: Mappable {
  var cidList: [Cid]!
  
  init(cidList: [Cid]) {
    self.cidList = cidList
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    cidList <- map["response.list"]
  }
}