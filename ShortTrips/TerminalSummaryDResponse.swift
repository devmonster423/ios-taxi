//
//  TerminalSummaryDResponse.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import ObjectMapper

struct TerminalSummaryDResponse: Mappable {
  var terminalSummaryDeparturesResponse: TerminalSummaryDeparturesResponse!
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    terminalSummaryDeparturesResponse <- map["response"]
  }
}