//
//  TripBody.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/13/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct TripBody: Mappable {
  var sessionId: Int!
  var medallion: Int?
  var vehicleId: Int!
  var smartCardId: String!
  var deviceUuid: String!
  
  init(sessionId: Int, medallion: Int?, vehicleId: Int, smartCardId: String) {
    self.sessionId = sessionId
    self.medallion = medallion
    self.vehicleId = vehicleId
    self.smartCardId = smartCardId
    self.deviceUuid = UIDevice.currentDevice().identifierForVendor!.UUIDString
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    sessionId <- map["session_id"]
    medallion <- map["medallion"]
    vehicleId <- map["vehicle_id"]
    smartCardId <- map["driver_card_id"]
    deviceUuid <- map["device_uuid"]
  }
}
