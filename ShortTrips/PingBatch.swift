//
//  PingBatch.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/8/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct PingBatchWrapper: Mappable {
  var pingBatch: String?

  init?(_ map: Map){}
  
  init(_ pingBatch: PingBatch) {
    self.pingBatch = Mapper().toJSONString(pingBatch, prettyPrint: false)
  }
  
  mutating func mapping(map: Map) {
    pingBatch <- map["pings"]
  }
}

struct PingBatch: Mappable {
  var sessionId: Int!
  var pings: [Ping]!
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    sessionId <- map["session_id"]
    pings <- map["pings"]
  }
}
