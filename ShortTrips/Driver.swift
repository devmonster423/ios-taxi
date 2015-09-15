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

  init(sessionId: Int, driverId: Int, cardId: Int, firstName: String, lastName: String) {
    self.sessionId = sessionId
    self.driverId = driverId
    self.cardId = cardId
    self.firstName = firstName
    self.lastName = lastName
  }

  init() {}

  static func newInstance(map: Map) -> Mappable? {
    return Driver()
  }

  mutating func mapping(map: Map) {
    sessionId <- map["session_id"]
    driverId <- map["driver_id"]
    cardId <- map["card_id"]
    firstName <- map["first_name"]
    lastName <- map["last_name"]
  }
}