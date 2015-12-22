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

  init?(_ map: Map){}
  
  init(jsonFileName: String, sfoGeofence: SfoGeofence) {
    let path = NSBundle.mainBundle().pathForResource(jsonFileName, ofType: "json")!
    
    var jsonString: String!
    
    do {
      jsonString = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String
    } catch {}
    
    self = Mapper<LocalGeofence>().map(jsonString!)!
    self.sfoGeofence = sfoGeofence
  }

  mutating func mapping(map: Map) {
    features <- map["features"]
  }
}
