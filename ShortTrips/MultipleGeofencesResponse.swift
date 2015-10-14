//
//  MultipleGeofenceResponse.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

import ObjectMapper

struct MultipleGeofencesResponse: Mappable {
  var geofenceListWrapper: GeofenceListWrapper?
  
  init(geofenceListWrapper: GeofenceListWrapper) {
    self.geofenceListWrapper = geofenceListWrapper
  }
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    geofenceListWrapper <- map["response"]
  }
}
