//
//  Geofence.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/12/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import ObjectMapper

enum Category: String {
  case City = "city"
  case Location = "location"
  case Place = "place"
}

struct Geofence: Mappable {
  var category: Category?
  var description: String?
  var geofenceId: Int!
  var name: String!
  
  init(category: Category, description: String, geofenceId: Int, name: String) {
    self.category = category
    self.description = description
    self.geofenceId = geofenceId
    self.name = name
  }

  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    category <- map["category"]
    description <- map["description"]
    name <- map["name"]
    geofenceId <- map["id"] // was "geofence_id", see discussion: https://basecamp.com/1759841/projects/9992902/messages/49598451
  }
}
