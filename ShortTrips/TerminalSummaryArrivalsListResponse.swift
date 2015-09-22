//
//  TerminalSummaryArrivalsListResponse.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/17/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import ObjectMapper

struct TerminalSummaryArrivalsListResponse: Mappable {
  var terminalSummaryArrivalsList: [TerminalSummary]!
  var totalCount: Int!
  var totalDelayedCount: Int!
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    terminalSummaryArrivalsList <- map["list"]
    totalCount <- map["total_count"]
    totalDelayedCount <- map["total_delayed_count"]
  }
}
