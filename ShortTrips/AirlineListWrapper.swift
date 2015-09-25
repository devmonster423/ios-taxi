//
//  AirlinesWrapper.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/24/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import ObjectMapper

struct AirlineListWrapper: Mappable {
  var airlines: [Airline]!
  
  init(airlines: [Airline]) {
    self.airlines = airlines
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    airlines <- map["airlines"]
  }
}
