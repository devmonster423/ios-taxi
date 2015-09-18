//
//  TerminalSummaryArrivalsResponse.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/17/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import ObjectMapper

struct TerminalSummaryArrivalsResponse: Mappable {
  var terminalSummaryArrivalsListResponse: TerminalSummaryArrivalsListResponse!
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    terminalSummaryArrivalsListResponse <- map["arrivals"]
  }
}
