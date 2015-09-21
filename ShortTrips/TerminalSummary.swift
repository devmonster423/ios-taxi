//
//  TerminalSummary.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/2/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import ObjectMapper

// This code uses the nomenclature of the SFO terminals themselves. I note that this
// nomenclature is slightly misleading because, according to Wikipedia, there are plans
// to expand Terminal 1 by "effectively add[ing] two gates that can handle international
// arrivals." That said, the nomenclature is, I presume, familiar to and useful for taxi
// drivers notwithstanding any potential inaccuracy.
enum TerminalId: String {
  case One = "One"
  case Two = "Two"
  case Three = "Three"
  case International = "International"
  
  var intValue: Int {
    switch self {
    case .One:
      return 1
    case .Two:
      return 2
    case .Three:
      return 3
    case .International:
      return 4
    }
  }
}

struct TerminalSummary: Mappable {
  var terminalId: TerminalId!
  var count: Int!
  var delayedCount: Int!
  
  init?(_ map: Map){}
  
  init(terminalId: TerminalId, count: Int, delayedCount: Int) {
    self.terminalId = terminalId
    self.count = count
    self.delayedCount = delayedCount
  }
  
  mutating func mapping(map: Map) {
    terminalId <- map["terminal_id"]
    count <- map["count"]
    delayedCount <- map["delayed_count"]
  }
}
