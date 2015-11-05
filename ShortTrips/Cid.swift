//
//  Cid.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

enum CidDevice {
  case TaxiEntry
  case TaxiMainLot
  case NonDispatchedTaxiExit
  case TaxiStagingExit
  
  static func from(id: String) -> CidDevice? {
    switch id {
    case "CD11", "CID12", "CID13", "CID14":
      return .TaxiEntry
    case "CD21", "CID22", "CID23":
      return .TaxiMainLot
    case "CID31", "CID32":
      return .NonDispatchedTaxiExit
    case "CID41":
      return .TaxiStagingExit
    default:
      return nil
    }
  }
  
  func name() -> String {
    switch self {
    case TaxiEntry:
      return "Location #27 Taxi Entry"
    case TaxiMainLot:
      return "Location #15 Taxi Main Lot"
    case NonDispatchedTaxiExit:
      return "Location #16 Non-Dispatched Taxi Exit"
    case TaxiStagingExit:
      return "Location #17 Taxi Staging Exit"

    }
  }
}


struct Cid: Mappable {
  var cidId: String!
  var cidLocation: String!
  var cidTimeRead: NSDate!

  init(cidId: String, cidLocation: String, cidTimeRead: NSDate) {
    self.cidId = cidId
    self.cidLocation = cidLocation
    self.cidTimeRead = cidTimeRead
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    let transform = DateTransform(dateFormat: "yyyy-MM-dd HH:mm:ss.SS") // "2015-09-03 09:19:20.99"
    
    cidId <- map["device_id"]
    cidLocation <- map["device_location"]
    cidTimeRead <- (map["time_read"], transform)
  }
  
  func device() -> CidDevice? {
    return CidDevice.from(cidId)
  }
}




