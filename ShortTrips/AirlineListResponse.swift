//
//  AirlineListResponse.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/24/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import ObjectMapper

struct AirlineListResponse: Mappable {
  var airlineListWrapper: AirlineListWrapper!
  
  init(airlineListWrapper: AirlineListWrapper) {
    self.airlineListWrapper = airlineListWrapper
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    airlineListWrapper <- map["response"]
  }
}
