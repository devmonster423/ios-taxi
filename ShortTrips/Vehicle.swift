//
//  Vehicle.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/16/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct Vehicle: Mappable {
  var gtmsTripId: Int!
  var licensePlate: String!
  var medallion: String?
  var transponderId: Int!
  var vehicleId: Int!
  
  init(gtmsTripId: Int, licensePlate: String, medallion: String, transponderId: Int, vehicleId: Int) {
    self.gtmsTripId = gtmsTripId
    self.licensePlate = licensePlate
    self.medallion = medallion
    self.transponderId = transponderId
    self.vehicleId = vehicleId
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    
    let medallionTransform = TransformOf<String, Any>(fromJSON: { (input) -> String? in
      if let input = input as? String {
        return input
      } else if let input = input as? Int {
        return "\(input)"
      } else {
        return nil
      }
      }) { (medallion) -> Any? in
        return medallion
    }
    
    gtmsTripId <- map["response.gtms_trip_id"]
    licensePlate <- map["response.license_plate"]
    medallion <- (map["response.medallion"], medallionTransform)
    transponderId <- map["response.transponder_id"]
    vehicleId <- map["response.vehicle_id"]
  }
  
  func isValid() -> Bool {
    return gtmsTripId != nil
      && licensePlate != nil
      && medallion != nil
      && transponderId != nil
      && vehicleId != nil
  }
}
