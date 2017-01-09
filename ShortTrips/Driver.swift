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
  var cardId: String!
  var firstName: String?
  var lastName: String?
  var driverLicense: String!

  init(sessionId: Int, driverId: Int, cardId: String, firstName: String, lastName: String, driverLicense: String) {
    self.sessionId = sessionId
    self.driverId = driverId
    self.cardId = cardId
    self.firstName = firstName
    self.lastName = lastName
    self.driverLicense = driverLicense
  }

  init?(map: Map){}

  mutating func mapping(map: Map) {
    sessionId <- map["response.session_id"]
    driverId <- map["response.driver_id"]
    cardId <- map["response.card_id"]
    firstName <- map["response.first_name"]
    lastName <- map["response.last_name"]
    driverLicense <- map["response.driver_license"]
  }
  
  func fullName() -> String? {
    if let firstName = firstName, let lastName = lastName {
      return firstName + " " + lastName
    } else {
      return nil
    }
  }
}
