//
//  Airline.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/1/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import UIKit

enum Airline {
  // TODO: Add cases for all airlines.
  case DeltaAirlines
  case VirginAmerica
  case UnitedAirlines
  case AirFrance
  case BritishAirways
  case Lufthansa
  case AerLingus

  // TODO: Add icons for all airlines.
  func icon() -> UIImage {
    switch self {
    case .DeltaAirlines:
      return UIImage(named: "DeltaAirlines")!
    case .VirginAmerica:
      return UIImage(named: "VirginAmerica")!
    case .AerLingus:
      return UIImage(named: "AerLingus")!
    case .AirFrance:
      return UIImage(named: "AirFrance")!
    case .Lufthansa:
      return UIImage(named: "Lufthansa")!
    case .BritishAirways:
      return UIImage(named: "BritishAirways")!
    case .UnitedAirlines:
      return UIImage(named: "UnitedAirlines")!
    default:
      return UIImage(named: "unknownAirline")!
    }
  }
}
