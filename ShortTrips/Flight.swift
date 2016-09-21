//
//  Flight.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/1/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import ObjectMapper

enum FlightType: String {
  case Arrivals = "Arrivals"
  case Departures = "Departures"
  
  static func all() -> [FlightType] {
    return [.Arrivals, .Departures]
  }
  
  func asLocalizedString() -> String {
    return NSLocalizedString(self.rawValue, comment: "")
  }
}

struct Flight: Mappable {
  var airline: String!
  var bags: Int!
  var estimatedTime: NSDate!
  var flightNumber: String!
  var flightStatus: FlightStatus?
  var scheduledTime: NSDate!
  static let timeCushion: NSTimeInterval = 900.0
  static let transform = DateTransform(dateFormat: "hh:mm a") // "2:50 PM"
  
  init(airline: String, bags: Int, estimatedTime: NSDate, flightStatus: FlightStatus, flightNumber: String, scheduledTime: NSDate) {
    self.airline = airline
    self.bags = bags
    self.estimatedTime = estimatedTime
    self.flightStatus = flightStatus
    self.flightNumber = flightNumber
    self.scheduledTime = scheduledTime
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(_ map: Map) {
    airline <- map["airline_name"]
    bags <- map["bags"]
    estimatedTime <- (map["estimated_time"], Flight.transform)
    flightNumber <- map["flight_number"]
    flightStatus <- map["remarks"]
    scheduledTime <- (map["scheduled_time"], Flight.transform)
  }
  
  static func isValid(_ flights: [Flight]) -> Bool {
    
    for flight in flights {
      if flight.airline == nil
        || flight.bags == nil
        || flight.estimatedTime == nil
        || flight.flightNumber == nil
        || flight.scheduledTime == nil {
          
          return false
      }
    }
    
    return true
  }
  
  static func airlineImageForFlight(_ flightNumber: String, width: Int, height: Int, completion: ImageClosure) {
    ApiClient.imageForIataCode(iataCodeForFlightNumber(flightNumber), width: width, height: height, completion: completion)
  }
  
  fileprivate static func iataCodeForFlightNumber(_ flightNumber: String) -> String {
     return flightNumber.substring(with: Range<String.Index>(
      flightNumber.startIndex ..< flightNumber.characters.index(flightNumber.startIndex, offsetBy: 2)))
  }

  static func mungeStatus(_ scheduled: NSDate, estimated: NSDate) -> FlightStatus {
    return scheduled.dateByAddingTimeInterval(timeCushion).compare(estimated) == .OrderedAscending ? .Delayed : .OnTime
  }
}
