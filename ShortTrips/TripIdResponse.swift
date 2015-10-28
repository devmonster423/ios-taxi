//
//  TripIdResponse.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/28/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct TripIdResponse: Mappable {
  var tripId: TripId!
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    tripId <- map["response"]
  }
}
