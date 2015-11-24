//
//  Util.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/19/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

struct Util {
  static var debug = true
  
  enum HttpStatusCodes: Int {
    case Ok = 200
  }
  
  static func testing() -> Bool {
    let dict = NSProcessInfo.processInfo().environment
    if let testing = dict["TESTING"] where testing == "true" {
      return true
    } else {
      return false
    }
  }
}