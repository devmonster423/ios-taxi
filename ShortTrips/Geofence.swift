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
  case brisbane = 1
  case burlingame = 2
  case fosterCity = 3
  case hillsborough = 4
  case millbrae = 5
  case sanBruno = 6
  case unincorp = 7
  case sanMateo = 8
  case southSanFrancisco = 9
  case sfo = 10
  case sfoTaxiDomesticExit = 11
  case sfoTaxiEntryGate = 12
  case sfoInternationalExit = 13
  case openSpace = 15
  case colma = 16
  case dalyCity = 17
  case sfoTerminalExit = 18
  case taxiWaitingZone = 19
  case taxiSfoMerged = 23
  case taxiExitBuffered = 99 // not on server database
}

struct Geofence: Mappable {
  var category: Category?
  var description: String?
  var geofence: SfoGeofence?
  var name: String!
  
  init(category: Category, description: String, geofence: SfoGeofence, name: String) {
    self.category = category
    self.description = description
    self.geofence = geofence
    self.name = name
  }
  
  init(_ localGeofence: LocalGeofence) {
    // TODO
  }

  init?(_ map: Map){}
  
  mutating func mapping(_ map: Map) {
    category <- map["category"]
    description <- map["description"]
    name <- map["name"]
    geofence <- map["id"] // was "geofence_id", see discussion: https://basecamp.com/1759841/projects/9992902/messages/49598451
  }
}
