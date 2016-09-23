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
  var sfoGeofence: SfoGeofence!

  init?(map: Map){}
  
  init(jsonFileName: String, sfoGeofence: SfoGeofence) {
    let path = Bundle.main.path(forResource: jsonFileName, ofType: "json")!
    
    var jsonString: String!
    
    do {
      jsonString = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue) as String
    } catch {}
    
    self = LocalGeofence(JSONString: jsonString)!
    self.sfoGeofence = sfoGeofence
  }

  mutating func mapping(map: Map) {
    features <- map["features"]
  }
}
