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
  var smartCardId: String!
  
  init(sessionId: Int, medallion: Int, smartCardId: String) {
    self.sessionId = sessionId
    self.medallion = medallion
    self.smartCardId = smartCardId
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    sessionId <- map["session_id"]
    medallion <- map["medallion"]
    smartCardId <- map["driver_card_id"]
  }
}
