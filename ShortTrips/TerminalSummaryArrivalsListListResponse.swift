//
//  TerminalSummaryArrivalsListListResponse.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/17/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import ObjectMapper

struct TerminalSummaryArrivalsListListResponse: Mappable {
  var terminalSummaryArrivalsList: [TerminalSummary]!
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    terminalSummaryArrivalsList <- map["list"]
  }
}

