//
//  FlightStatus.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/2/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import UIKit

enum FlightStatus: String {
  case Delayed = "Delayed"
  case OnTime = "On Time"
  case Landing = "Landing"
  case Landed = "Landed"
  
  func getTimeColor() -> CGColor {
    switch self {
    case .Delayed:
      return UiConstants.delayedColor
    default:
      return UiConstants.landedColor
    }
  }
  
  func getStatusColor() -> CGColor {
    switch self {
    case .Delayed:
      return UiConstants.delayedColor
    case .OnTime:
      return UiConstants.onTimeColor
    case .Landing:
      return UiConstants.landingColor
    case Landed:
      return UiConstants.landedColor
    }
  }
}
