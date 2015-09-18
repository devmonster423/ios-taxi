//
//  FlightsForTerminalResponse.swift
//  ShortTrips
//
//  Created by Joshua Adams and 😺 on 9/17/15.
//  Copyright © 2015 SFO. All rights reserved.
//
import ObjectMapper

struct FlightsForTerminalResponse: Mappable {
  var flightDetailResponse: FlightDetailResponse!
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    flightDetailResponse <- map["response"]
  }
}
