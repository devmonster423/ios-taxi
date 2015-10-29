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
  case Payment = "payment"
  case Exit = "exit"
}

struct Antenna: Mappable {
  var antennaId: Int!
  var aviLocation: AviLocation!
  
  init(antennaId: Int, aviLocation: AviLocation) {
    self.antennaId = antennaId
    self.aviLocation = aviLocation
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    antennaId <- map["antenna_id"]
    aviLocation <- map["avi_location"]
  }
}