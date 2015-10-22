//
//  TerminalSummaryDeparturesResponse.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import ObjectMapper

struct TerminalSummaryDeparturesResponse: Mappable {
  var terminalSummaryListResponse: TerminalSummaryListResponse!
  
  init?(_ map: Map){}
  
  init(terminalSummaryListResponse: TerminalSummaryListResponse) {
    self.terminalSummaryListResponse = terminalSummaryListResponse
  }
  
  mutating func mapping(map: Map) {
    terminalSummaryListResponse <- map["departures"]
  }
}