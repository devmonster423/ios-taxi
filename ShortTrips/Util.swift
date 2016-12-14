//
//  Util.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/19/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import UIKit

struct Util {
  static let debug = false
  static var testingGps = false
  
  enum HttpStatusCodes: Int {
    case ok = 200
  }
  
  static func testing() -> Bool {
    let dict = ProcessInfo.processInfo.environment
    if let testing = dict["TESTING"], testing == "true" {
      return true
    } else {
      return false
    }
  }
  
  static func versionString() -> String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
  }
  
  static func isIphone4Or5() -> Bool {
    return UIScreen.main.bounds.size.height <= 568
  }
}
