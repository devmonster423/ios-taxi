//
//  Cid.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct Cid: Mappable {
  var cidId: String!
  var cidLocation: String!
  var cidTimeRead: NSDate?

  init(cidId: String, cidLocation: String, cidTimeRead: NSDate) {
    self.cidId = cidId
    self.cidLocation = cidLocation
    self.cidTimeRead = cidTimeRead
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    let transform = DateTransform(dateFormat: "yyyy-MM-dd HH:mm:ss.SS") // "2015-09-03 09:19:20.99"
    cidId <- map["response.device_id"]
    cidLocation <- map["response.device_location"]
    cidTimeRead <- (map["response.time_read"], transform)
  }
  
  func device() -> GtmsLocation? {
    return GtmsLocation.from(cidId: cidId)
  }
}
