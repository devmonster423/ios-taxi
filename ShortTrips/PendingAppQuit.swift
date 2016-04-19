//
//  PendingAppQuit.swift
//  ShortTrips
//
//  Created by Matt Luedke on 4/19/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation

struct PendingAppQuit {
  
  private static let appQuitKey = "app_quit"
  
  static func get() -> Int? {
    let tripId = NSUserDefaults.standardUserDefaults().integerForKey(appQuitKey)
    return tripId != 0 ? tripId : nil
  }
  
  static func set(pendingAppQuit: Int?) {
    NSUserDefaults.standardUserDefaults()
      .setInteger(pendingAppQuit ?? 0, forKey: appQuitKey)
  }
}
