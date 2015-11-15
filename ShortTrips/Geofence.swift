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

enum SfoGeofence: Int {
  case Millbrae = 5
  case SanBruno = 6
  case Sfo = 10
  case SfoInternationalExit = 13
  case SfoTerminalExit = 18

  func name() -> String {
    switch self {
    case .Millbrae:
      return "Millbrae"
    case .SanBruno:
      return "San Bruno"
    case Sfo:
      return "San Francisco International Airport"
    case SfoInternationalExit:
      return "SFO International Exit"
    case SfoTerminalExit:
      return "SFO Terminal Exit"
    }
  }
}

struct Geofence: Mappable {
  var category: Category?
  var description: String?
  var geofence: SfoGeofence!
  var name: String!
  
  init(category: Category, description: String, geofence: SfoGeofence, name: String) {
    self.category = category
    self.description = description
    self.geofence = geofence
    self.name = name
  }

  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    category <- map["category"]
    description <- map["description"]
    name <- map["name"]
    geofence <- map["id"] // was "geofence_id", see discussion: https://basecamp.com/1759841/projects/9992902/messages/49598451
  }
}
