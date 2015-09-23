//
//  Flight.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/1/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import ObjectMapper

struct Flight: Mappable {
  var airline: String!
  var bags: Int!
  var estimatedTime: NSDate!
  var flightNumber: String!
  var flightStatus: FlightStatus?
  var scheduledTime: NSDate!
  
  init(airline: String, bags: Int, estimatedTime: NSDate, flightStatus: FlightStatus, flightNumber: String, scheduledTime: NSDate) {
    self.airline = airline
    self.bags = bags
    self.estimatedTime = estimatedTime
    self.flightStatus = flightStatus
    self.flightNumber = flightNumber
    self.scheduledTime = scheduledTime
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {

    let transform = DateTransform(dateFormat: "hh:mm a") // "2:50 PM"

    airline <- map["airline_name"]
    bags <- map["bags"]
    estimatedTime <- (map["estimated_time"], transform)
    flightNumber <- map["flight_number"]
    flightStatus <- map["remarks"]
    scheduledTime <- (map["scheduled_time"], transform)
  }
}