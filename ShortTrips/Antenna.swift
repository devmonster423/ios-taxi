//
//  Antenna.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct Antenna: Mappable {
  var antennaId: String!
  var aviLocation: String!
  var aviDate: NSDate!
  
  init(antennaId: String, aviLocation: String, aviDate: NSDate) {
    self.antennaId = antennaId
    self.aviLocation = aviLocation
    self.aviDate  = aviDate
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    let transform = DateTransform(dateFormat: "yyyy-MM-dd HH:mm:ss.SSS") // "2015-09-03 09:19:20.563"
    antennaId <- map["response.device_id"]
    aviLocation <- map["response.device_location"]
    aviDate <- (map["response.device_date"], transform)
  }
  
  func device() -> GtmsLocation? {
    return GtmsLocation.from(aviId: antennaId)
  }
}