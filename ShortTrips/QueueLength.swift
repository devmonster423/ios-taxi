//
//  Queue.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/13/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct QueueLength: Mappable {
  var longQueueLength: Int!
  var shortQueueLength: Int!
  
  init?(map: Map){}
  
  mutating func mapping(map: Map) {
    longQueueLength <- map["response.long_queue_length"]
    shortQueueLength <- map["response.short_queue_length"]
  }
}
