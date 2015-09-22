//
//  DateTransform.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/22/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

public struct DateTransform: TransformType {

  var dateFormat: String

  public init(dateFormat: String) {
    self.dateFormat = dateFormat
  }

  public func transformFromJSON(value: AnyObject?) -> NSDate? {
    if let stringValue = value as? String {
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = dateFormat
      return dateFormatter.dateFromString(stringValue)
    }
    return nil
  }

  public func transformToJSON(value: NSDate?) -> String? {
    if let date = value {
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = dateFormat
      return dateFormatter.stringFromDate(date)
    }
    return nil
  }
}
