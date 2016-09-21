//
//  Terms.swift
//  ShortTrips
//
//  Created by Matt Luedke on 3/14/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation

struct Terms {
  
  fileprivate static let preferenceKey = "terms_and_conditions"
  
  static func agreedTerms() -> String? {
    return UserDefaults.standard.string(forKey: preferenceKey)
  }
  
  static func saveTerms(_ terms: String) {
    UserDefaults.standard.set(terms, forKey: preferenceKey)
  }
}
