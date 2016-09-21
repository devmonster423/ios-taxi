//
//  PingBatch.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/8/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct PingBatch: Mappable {
  var sessionId: String!
  var pings: [Ping]!
  
  init?(_ map: Map){}
  
  init(sessionId: Int, pings: [Ping]) {
    self.sessionId = "\(sessionId)"
    self.pings = pings
  }
  
  mutating func mapping(_ map: Map) {
    sessionId <- map["session_id"]
    pings <- map["pings"]
  }
}
