//
//  TerminalSummaryListResponse.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/17/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import ObjectMapper

struct TerminalSummaryListResponse: Mappable {

  var terminalSummaryList: [TerminalSummary]!
  var totalCount: Int!
  var totalDelayedCount: Int!
  
  init?(_ map: Map){}
  
  init(terminalSummaryList: [TerminalSummary]) {
    self.terminalSummaryList = terminalSummaryList
  }
  
  mutating func mapping(map: Map) {
    terminalSummaryList <- map["list"]
    totalCount <- map["total_count"]
    totalDelayedCount <- map["total_delayed_count"]
  }
}
