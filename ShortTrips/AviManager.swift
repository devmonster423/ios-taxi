//
//  CidManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/20/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation

class AviManager {
  static let sharedInstance = AviManager()
  
  private var latestAviLocation: GtmsLocation?
  
  func setLatestAviLocation(latestAviLocation: GtmsLocation) {
    self.latestAviLocation = latestAviLocation
  }
  
  func latestAviInTaxiEntryOrStatus() -> Bool {
    if let latestAviLocation = latestAviLocation {
      return latestAviLocation == .TaxiEntry
        || latestAviLocation == .TaxiStatus
    } else {
      return false
    }
  }
}