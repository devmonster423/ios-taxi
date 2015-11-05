//
//  Driver.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/14/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

struct Driver: Mappable {
  var sessionId: Int!
  var driverId: Int!
  var cardId: Int!
  var firstName: String!
  var lastName: String!
  var driverLicense: String!

  init(sessionId: Int, driverId: Int, cardId: Int, firstName: String, lastName: String, driverLicense: String) {
    self.sessionId = sessionId
    self.driverId = driverId
    self.cardId = cardId
    self.firstName = firstName
    self.lastName = lastName
    self.driverLicense = driverLicense
  }

  init?(_ map: Map){}

  mutating func mapping(map: Map) {
    sessionId <- map["session_id"]
    driverId <- map["driver_id"]
    cardId <- map["card_id"]
    firstName <- map["first_name"]
    lastName <- map["last_name"]
    driverLicense <- map["driver_license"]
  }
}