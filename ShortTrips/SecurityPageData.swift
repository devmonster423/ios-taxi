//
//  SecurityPageData.swift
//  ShortTrips
//
//  Created by Matt Luedke on 7/18/17.
//  Copyright © 2017 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct SecurityPageData: Mappable {
  var data: String!
  
  init?(map: Map){}
  
  mutating func mapping(map: Map) {
    data <- map["data"]
  }
}
