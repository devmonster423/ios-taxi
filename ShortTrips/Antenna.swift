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
  var aviDate: Date!
  
  static let transform = DateTransform(dateFormat: "yyyy-MM-dd HH:mm:ss.SSS") // "2015-09-03 09:19:20.563"
  
  init(antennaId: String, aviLocation: String, aviDate: Date) {
    self.antennaId = antennaId
    self.aviLocation = aviLocation
    self.aviDate  = aviDate
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(_ map: Map) {
    antennaId <- map["response.device_id"]
    aviLocation <- map["response.device_location"]
    aviDate <- (map["response.time_read"], Antenna.transform)
  }
  
  func device() -> GtmsLocation? {
    return GtmsLocation.from(aviId: antennaId)
  }
}
