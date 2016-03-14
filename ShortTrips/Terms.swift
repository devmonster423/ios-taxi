//
//  Terms.swift
//  ShortTrips
//
//  Created by Matt Luedke on 3/14/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation

struct Terms {
  
  private static let preferenceKey = "terms_and_conditions"
  
  static func agreedTerms() -> String? {
    return NSUserDefaults.standardUserDefaults().stringForKey(preferenceKey)
  }
  
  static func saveTerms(terms: String) {
    NSUserDefaults.standardUserDefaults().setObject(terms, forKey: preferenceKey)
  }
}
