//
//  FlightDetailsWrapper.swift
//  ShortTrips
//
//  Created by Josh Adams and 🐈 on 9/17/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import ObjectMapper

struct FlightDetailsWrapper: Mappable {
  var flightDetails: [Flight]!
  var terminalId: TerminalId!
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    flightDetails <- map["response.details"]
    terminalId <- map["response.terminal_id"]
  }
}
