//
//  TerminalSummaryArrivalsWrapper.swift
//  ShortTrips
//
//  Created by Joshua Adams on 11/8/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct TerminalSummaryArrivalsWrapper: Mappable {
  var terminalSummaries: [TerminalSummary]!
  var totalCount: Int!
  var totalDelayedCount: Int!
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    terminalSummaries <- map["response.arrivals.list"]
    totalCount <- map["response.total_count"]
    totalDelayedCount <- map["response.total_delayed_count"]
  }
}
