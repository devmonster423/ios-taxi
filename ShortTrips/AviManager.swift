//
//  AviManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/19/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation

class AviManager {
  static let sharedInstance = AviManager()
  
  var lastKnownAvi: Antenna?
}
