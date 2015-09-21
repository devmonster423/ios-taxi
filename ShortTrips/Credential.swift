//
//  Credential.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/18/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import ObjectMapper

struct Credential: Mappable {
  var username: String!
  var password: String!
  
  init(username: String, password: String) {
    self.username = username
    self.password = password
  }
  
  init() {}
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    username <- map["username"]
    password <- map["password"]
  }
}