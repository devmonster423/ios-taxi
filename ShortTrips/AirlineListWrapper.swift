//
//  AirlineListWrapper.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/24/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import ObjectMapper

struct AirlineListWrapper: Mappable {
  var airlines: [Airline]!

  init?(map: Map){}
  
  mutating func mapping(map: Map) {
    airlines <- map["response.airlines"]
  }
}
