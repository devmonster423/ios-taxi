//
//  Antenna.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

enum AviLocation {
  case TaxiEntry
  case TaxiMainLot
  case NonDispatchedTaxiExit
  case TaxiStagingExit
  
  static func from(id: String) -> AviLocation? {
    switch id {
    case "L15AVI1", "L15AVI2", "L15AVI3":
      return .TaxiMainLot
    case "L16AVI1":
      return .NonDispatchedTaxiExit
    case "L17AVI1":
      return .TaxiStagingExit
    case "L27AVI1", "L27AVI2":
      return .TaxiEntry
    default:
      return nil
    }
  }

  func name() -> String {
    switch self {
    case TaxiMainLot:
      return "Location #15 Taxi Main Lot"
    case NonDispatchedTaxiExit:
      return "Location #16 Non-Dispatched Taxi Exit"
    case TaxiStagingExit:
      return "Location #17 Taxi Staging Exit"
    case TaxiEntry:
      return "Location #27 Taxi Entry"
    }
  }
}


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
  
  func device() -> AviLocation? {
    return AviLocation.from(antennaId)
  }
}