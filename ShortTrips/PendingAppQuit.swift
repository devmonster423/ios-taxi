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
  
  static func get() -> Bool {
    return NSUserDefaults.standardUserDefaults().boolForKey(appQuitKey)
  }
  
  static func set(pendingAppQuit: Bool) {
    NSUserDefaults.standardUserDefaults().setBool(pendingAppQuit, forKey: appQuitKey)
  }
}
