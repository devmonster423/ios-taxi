//
//  SfoDateTransform.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/22/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

public struct SfoDateTransform: TransformType {

  var dateFormat: String

  public init(dateFormat: String) {
    self.dateFormat = dateFormat
  }

  public func transformFromJSON(_ value: Any?) -> Date? {
    if let stringValue = value as? String {
      let dateFormatter = DateFormatter()
      dateFormatter.locale = Locale(identifier: "en_US_POSIX")
      dateFormatter.dateFormat = dateFormat
      return dateFormatter.date(from: stringValue)
    }
    return nil
  }

  public func transformToJSON(_ value: Date?) -> String? {
    if let date = value {
      let dateFormatter = DateFormatter()
      dateFormatter.locale = Locale(identifier: "en_US_POSIX")
      dateFormatter.dateFormat = dateFormat
      return dateFormatter.string(from: date)
    }
    return nil
  }
}
