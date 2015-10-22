//
//  TerminalSummaryArrivalsResponse.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/17/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import ObjectMapper

struct TerminalSummaryArrivalsResponse: Mappable {
  var terminalSummaryListResponse: TerminalSummaryListResponse!
  
  init?(_ map: Map){}
  
  init(terminalSummaryListResponse: TerminalSummaryListResponse) {
    self.terminalSummaryListResponse = terminalSummaryListResponse
  }
  
  mutating func mapping(map: Map) {
    terminalSummaryListResponse <- map["arrivals"]
  }
}
