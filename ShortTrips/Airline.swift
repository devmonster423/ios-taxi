//
//  Airline.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/24/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import ObjectMapper

typealias IataClosure = String? -> Void

struct Airline: Mappable {
  var airlineCode: String!
  var airlineName: String!
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    airlineCode <- map["airlineCode"]
    airlineName <- map["airlineName"]
  }
  
  static func loadImageForAirline(airlineName: String, width: Int, height: Int, completion: ImageClosure) {
    
    iataCodeForAirline(airlineName) { (iata) -> Void in
      
      if let iata = iata {
        ApiClient.imageForIataCode(iata, width: width, height: height, completion: completion)
      }
    }
  }
  
  private static func iataCodeForAirline(airlineName: String, completion: IataClosure) {
    
    ApiClient.codes { (airlines, error) -> Void in
      if let airlines = airlines {
        for airline in airlines {
          if airline.airlineName == airlineName {
            completion(airline.airlineCode)
          }
        }
      }
    }
  }
}
