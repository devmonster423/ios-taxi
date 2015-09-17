//
//  Flight.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/1/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct Flight: Mappable {
  var airline: Airline!
  var landingTime: NSDate!
  var flightStatus: FlightStatus!
  var terminalId: TerminalId!
  var flightNumber: Int!
  
  init(airline: Airline, landingTime: NSDate, flightStatus: FlightStatus, terminalId: TerminalId, flightNumber: Int) {
    self.airline = airline
    self.landingTime = landingTime
    self.flightStatus = flightStatus
    self.terminalId = terminalId
    self.flightNumber = flightNumber
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    airline <- map["airline"]
    landingTime <- map["estimated_time"] // TODO: possibly use date mask
    flightStatus <- map["remarks"]
    flightNumber <- map["flight_number"]
  }
}