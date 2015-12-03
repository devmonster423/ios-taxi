//
//  GtmsLocation.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

enum GtmsLocation: String {
  case DtEntrance = "Location #1 DT Entrance"
  case DtExit = "Location #2 DT Exit"
  case ItaExit = "Location #3 ITA Exit"
  case CourtyardG = "Location #4 Courtyard G "
  case ItdExit = "Location #5 ITD exit"
  case CourtyardA = "Location #6 Courtyard A"
  case ItaEntrance = "Location #7 ITA Entrance"
  case ItdEntrance = "Location #8 ITD Entrance"
  case DtaEntrance = "Location #9 DTA Entrance"
  case TaxiBailOut = "Location #10 Taxi Bail-Out"
  case DtdEntrance = "Location #11 DTD Entrance"
  case DtaRecirculation = "Location #12 DTA Recirculation"
  case DtaExit = "Location #13 DTA Exit"
  case DtdRecirculation = "Location #14 DTD Recirculation"
  case TaxiMainLot = "Location #15 Taxi Main Lot"
  case NonDispatchedTaxiExit = "Location #16 Non-Dispatched Taxi Exit"
  case TaxiStatus = "Location #17 Taxi Status"
  case LotCc = "Location #18 Lot CC"
  case DomesticArrivalTerminal1 = "Domestic Arrival Terminal 1" // 19
  case DomesticArrivalTerminal2 = "Domestic Arrival Terminal 2" // 20
  case TaxiEntry = "Location #27 Taxi Entry"
  case GtuArea = "Location #33 GTU Area"
  case RentalCar = "Location #35 Rental Car"
  
//  case HoldingLotExit = "Location #12 Holding Lot Exit"
  case Inbound = "Location #1 Inbound"
  case TerminalExit = "Location #2 Terminal Exit"
  
  static func from(cidId id: String) -> GtmsLocation? {
    switch id {
    case "CID11", "CID12", "CID13", "CID14":
      return .TaxiEntry
    case "CID21", "CID22", "CID23":
      return .TaxiMainLot
    case "CID31", "CID32":
      return .NonDispatchedTaxiExit
    case "CID41":
      return .TaxiStatus
    default:
      return nil
    }
  }
  
  static func from(aviId id: String) -> GtmsLocation? {
    switch id {
    case "L1AVI1", "L1AVI2", "L1AVI3":
      return .DtEntrance
    case "L2AVI1", "L2AVI2", "L2AVI3":
      return .DtExit
    case "L3AVI1":
      return .ItaExit
    case "L4AVI1", "L4AVI2":
      return .CourtyardG
    case "L5AVI1", "L5AVI2":
      return .ItdExit
    case "L6AVI1":
      return .CourtyardA
    case "L7AVI1", "L7AVI2", "L7AVI3":
      return .ItaEntrance
    case "L8AVI1", "L8AVI2", "L8AVI3", "L8AVI4", "L8AVI5":
      return .ItdEntrance
    
//    case "L1AVI1":
//      return .Inbound
//    case "L2AVI1":
//      return .TerminalExit
    case "L9AVI1", "L9AVI2", "L9AVI3", "L9AVI4":
      return .DtaEntrance
    case "L10AVI1":
      return .TaxiBailOut
    case "L11AVI1", "L11AVI2", "L11AVI3", "L11AVI4":
      return .DtdEntrance
    case "L12AVI1":
      return .DtaRecirculation
    case "L13AVI1":
      return .DtaExit
    case "L14AVI1", "L14AVI2":
      return .DtdRecirculation
//    case "L12AVI1":
//      return .HoldingLotExit
    case "L15AVI1", "L15AVI2", "L15AVI3":
      return .TaxiMainLot
    case "L16AVI1":
      return .NonDispatchedTaxiExit
    case "L17AVI1":
      return .TaxiStatus
    case "L18AVI1":
      return .LotCc
    case "L19AVI1", "L19AVI2":
      return .DomesticArrivalTerminal1
    case "L20AVI1", "L20AVI2":
      return .DomesticArrivalTerminal2
    case "L27AVI1", "L27AVI2":
      return .TaxiEntry
    case "L33AVI1":
      return .GtuArea
    case "L35AVI1":
      return .RentalCar
    default:
      return nil
    }
  }
}

