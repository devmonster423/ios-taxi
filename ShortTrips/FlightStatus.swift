//
//  FlightStatus.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/2/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit

enum FlightStatus: String {
  case Delayed = "Delayed"
  case OnTime = "On Time"
  case Landing = "Landing"
  case Landed = "Landed"
  
  func getTimeOrFlightNumberColor() -> UIColor {
    switch self {
    case .Delayed:
      return Color.FlightStatus.delayed
    default:
      return Color.FlightStatus.landed
    }
  }
  
  func getStatusColor() -> UIColor {
    switch self {
    case .Delayed:
      return Color.FlightStatus.delayed
    case .OnTime:
      return Color.FlightStatus.onTime
    case .Landing:
      return Color.FlightStatus.landing
    case .Landed:
      return Color.FlightStatus.landed
    }
  }
}
