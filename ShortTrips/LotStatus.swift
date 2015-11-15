//
//  LotStatus.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/18/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import ObjectMapper

struct LotStatus: Mappable {
  var color: LotStatusEnum!
  var timestamp: NSDate!
  
  static let transform = DateTransform(dateFormat: "yyyy-MM-dd HH:mm:ss.SSS") // "2015-09-03 09:19:20.563"
  
  init?(_ map: Map){}
  
  init(color: LotStatusEnum, timestamp: NSDate) {
    self.color = color
    self.timestamp = timestamp
  }

  mutating func mapping(map: Map) {
    color <- map["response.color"]
    timestamp <- (map["response.timestamp"], LotStatus.transform)
  }
}


