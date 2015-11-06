//
//  GtmsLocation.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

enum GtmsLocation: String {
  case TaxiEntry = "Location #27 Taxi Entry"
  case TaxiMainLot = "Location #15 Taxi Main Lot"
  case NonDispatchedTaxiExit = "Location #16 Non-Dispatched Taxi Exit"
  case TaxiStagingExit = "Location #17 Taxi Staging Exit"
  
  static func from(cidId id: String) -> GtmsLocation? {
    switch id {
    case "CD11", "CID12", "CID13", "CID14":
      return .TaxiEntry
    case "CD21", "CID22", "CID23":
      return .TaxiMainLot
    case "CID31", "CID32":
      return .NonDispatchedTaxiExit
    case "CID41":
      return .TaxiStagingExit
    default:
      return nil
    }
  }
  
  static func from(aviId id: String) -> GtmsLocation? {
    switch id {
    case "L15AVI1", "L15AVI2", "L15AVI3":
      return .TaxiMainLot
    case "L16AVI1":
      return .NonDispatchedTaxiExit
    case "L17AVI1":
      return .TaxiStagingExit
    case "L27AVI1", "L27AVI2":
      return .TaxiEntry
    default:
      return nil
    }
  }
}

