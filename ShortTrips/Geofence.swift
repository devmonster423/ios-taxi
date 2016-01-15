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
  case Brisbane = 1
  case Burlingame = 2
  case FosterCity = 3
  case Hillsborough = 4
  case Millbrae = 5
  case SanBruno = 6
  case Unincorp = 7
  case SanMateo = 8
  case SouthSanFrancisco = 9
  case Sfo = 10
  case SfoTaxiDomesticExit = 11
  case SfoTaxiEntryGate = 12
  case SfoInternationalExit = 13
  case OpenSpace = 15
  case Colma = 16
  case DalyCity = 17
  case SfoTerminalExit = 18
  case TaxiWaitingZone = 19
  case TaxiSfoMerged = 23
  case TaxiExitBuffered = 99 // not on server database
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
  
  mutating func mapping(map: Map) {
    category <- map["category"]
    description <- map["description"]
    name <- map["name"]
    geofence <- map["id"] // was "geofence_id", see discussion: https://basecamp.com/1759841/projects/9992902/messages/49598451
  }
}
