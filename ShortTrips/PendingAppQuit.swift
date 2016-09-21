//
//  PendingAppQuit.swift
//  ShortTrips
//
//  Created by Matt Luedke on 4/19/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation

struct PendingAppQuit {
  
  fileprivate static let appQuitKey = "app_quit"
  
  static func get() -> Int? {
    let tripId = UserDefaults.standard.integer(forKey: appQuitKey)
    return tripId != 0 ? tripId : nil
  }
  
  static func set(_ pendingAppQuit: Int?) {
    UserDefaults.standard
      .set(pendingAppQuit ?? 0, forKey: appQuitKey)
  }
}
