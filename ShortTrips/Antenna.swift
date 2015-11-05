//
//  Antenna.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

enum AviLocation: String {
  case Entry = "entry"
  case Exit = "exit"
  case Inbound = "inbound"
  case Payment = "payment"
}

struct Antenna: Mappable {
  var antennaId: Int!
  var aviLocation: AviLocation!
  var aviDate: NSDate!
  
  init(antennaId: Int, aviLocation: AviLocation, aviDate: NSDate) {
    self.antennaId = antennaId
    self.aviLocation = aviLocation
    self.aviDate  = aviDate
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    let transform = DateTransform(dateFormat: "yyyy-MM-dd HH:mm:ss.SSS") // "2015-09-03 09:19:20.563"
    antennaId <- map["response.antenna_id"]
    aviLocation <- map["response.avi_location"]
    aviDate <- (map["response.avi_date"], transform)
  }
}