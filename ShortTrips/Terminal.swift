//
//  Terminal.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/2/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

// This code uses the nomenclature of the SFO terminals themselves. I note that this
// nomenclature is slightly misleading because, according to Wikipedia, there are plans
// to expand Terminal 1 by "effectively add[ing] two gates that can handle international
// arrivals." That said, the nomenclature is, I presume, familiar to and useful for taxi
// drivers notwithstanding any potential inaccuracy.
enum TerminalId {
  case One
  case Two
  case Three
  case International
}

struct Terminal: Mappable {
  var terminalId: TerminalId?
  var count: Int?
  var delayedCount: Int?
  
  static func newInstance(map: Map) -> Mappable? {
    return Terminal()
  }
  
  mutating func mapping(map: Map) {
    terminalId <- map["terminal_id"]
    count <- map["count"]
    delayedCount <- map["delayed_count"]
  }
}