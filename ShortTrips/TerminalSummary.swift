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
enum TerminalId: Int {
  case one = 1
  case two = 2
  case three = 3
  case international = 4
  
  func asLocalizedString() -> String {
    switch self {
    case .one:
      return NSLocalizedString("Terminal One", comment: "")
    case .two:
      return NSLocalizedString("Terminal Two", comment: "")
    case .three:
      return NSLocalizedString("Terminal Three", comment: "")
    case .international:
      return NSLocalizedString("Int'l Terminal", comment: "")
    }
  }
}

struct TerminalSummary: Mappable {
  var terminalId: TerminalId!
  var delayedCount: Int!
  var onTimeCount: Int!
  
  init?(map: Map){}
  
  init(terminalId: TerminalId, onTimeCount: Int, delayedCount: Int) {
    self.terminalId = terminalId
    self.onTimeCount = onTimeCount
    self.delayedCount = delayedCount
  }
  
  mutating func mapping(map: Map) {
    terminalId <- map["terminal_id"]
    onTimeCount <- map["count"]
    delayedCount <- map["delayed_count"]
  }
  
  static func getTotals(_ summaries: [TerminalSummary]?) -> (onTime: Int, delayed: Int) {
    var results = (onTime: 0, delayed: 0)
    if let summaries = summaries {
      for summary in summaries {
        results.onTime += summary.onTimeCount
        results.delayed += summary.delayedCount
      }
    }
    return results
  }
}

extension Sequence where Iterator.Element == TerminalSummary {
  func find(_ terminalId: TerminalId) -> TerminalSummary? {
    for summary in self {
      if summary.terminalId == terminalId {
        return summary
      }
    }
    return nil
  }
}
