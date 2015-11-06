//
//  GtmsLocation.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

enum GtmsLocation: String {
  // TODO verify names with server when implemented
  case HoldingLotExit = "Location #12 Holding Lot Exit"
  case HoldingLotStatus = "Location #17 Taxi Staging Exit"
  case Inbound = "Location #1 Inbound"
  case NonDispatchedTaxiExit = "Location #16 Non-Dispatched Taxi Exit"
  case Payment = "Location #15 Taxi Main Lot"
  case TaxiEntry = "Location #27 Taxi Entry"
  case TerminalExit = "Location #2 Terminal Exit"
  
  static func from(cidId id: String) -> GtmsLocation? {
    switch id {
    case "CD11", "CID12", "CID13", "CID14":
      return .TaxiEntry
    case "CD21", "CID22", "CID23":
      return .Payment
    case "CID31", "CID32":
      return .NonDispatchedTaxiExit
    case "CID41":
      return .HoldingLotStatus
    default:
      return nil
    }
  }
  
  static func from(aviId id: String) -> GtmsLocation? {
    switch id {
    case "L1AVI1":
      return .Inbound
    case "L2AVI1":
      return .TerminalExit
    case "L12AVI1":
      return .HoldingLotExit
    case "L15AVI1", "L15AVI2", "L15AVI3":
      return .Payment
    case "L16AVI1":
      return .NonDispatchedTaxiExit
    case "L17AVI1":
      return .HoldingLotStatus
    case "L27AVI1", "L27AVI2":
      return .TaxiEntry
    default:
      return nil
    }
  }
}

