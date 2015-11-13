//
//  TripBody.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/13/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct TripBody: Mappable {
  var sessionId: Int!
  var medallion: Int!
  
  init(sessionId: Int, medallion: Int) {
    self.sessionId = sessionId
    self.medallion = medallion
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    sessionId <- map["session_id"]
    medallion <- map["medallion"]
  }
}
