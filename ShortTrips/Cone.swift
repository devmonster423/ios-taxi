//
//  Cone.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/23/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import ObjectMapper

struct Cone: Mappable {
  static let inTransform = SfoDateTransform(dateFormat: "yyyy-MM-dd HH:mm:ss")
  static let outTransform = SfoDateTransform(dateFormat: "hh:mm a") // "2:50 PM"
  
  var isConed: Bool!
  var lastUpdated: Date!

  init?(map: Map){}
  
  mutating func mapping(map: Map) {
    isConed <- map["response.is_coned"]
    lastUpdated <- (map["response.last_updated"], Cone.inTransform)
  }
  
  func lastUpdatedString() -> String {
    return Cone.outTransform.transformToJSON(lastUpdated)!
  }
}
