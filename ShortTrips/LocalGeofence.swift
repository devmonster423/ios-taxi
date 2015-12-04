//
//  JsonGeofence.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/1/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct LocalGeofence: Mappable {

  var features: [LocalGeofenceFeature]!

  init?(_ map: Map){}

  mutating func mapping(map: Map) {
    features <- map["features"]
  }
}
