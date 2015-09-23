//
//  LotStatus.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/18/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import ObjectMapper

struct LotStatus: Mappable {
  var color: LotStatusEnum!
  var timestamp: NSDate!
  
  private let dateFormat = "yyyy-MM-dd HH:mm:ss.SSS" // "2015-09-03 09:19:20.563"
  private let dateFormatter = NSDateFormatter()
  
  init?(_ map: Map){}
  
  init(color: LotStatusEnum, timestamp: NSDate) {
    self.color = color
    self.timestamp = timestamp
  }

  mutating func mapping(map: Map) {
    
    let transform = TransformOf<NSDate, String>(fromJSON: { (value: String?) -> NSDate? in
      
      if let value = value {
        self.dateFormatter.dateFormat = self.dateFormat
        return self.dateFormatter.dateFromString(value)
      } else {
        return nil
      }
      }, toJSON: { (value: NSDate?) -> String? in
        
        if let value = value {
          self.dateFormatter.dateFormat = self.dateFormat
          return self.dateFormatter.stringFromDate(value)
        } else {
          return nil
        }
    })
    
    color <- map["color"]
    timestamp <- (map["timestamp"], transform)
  }
}


