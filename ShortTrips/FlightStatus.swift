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
  
  func getColor() -> UIColor {
    switch self {
    case .Delayed:
      return UIColor.redColor()
    case .OnTime:
      return UIColor.greenColor()
    case .Landing:
      return UIColor.blueColor()
    case Landed:
      return UIColor.blackColor()
    }
  }
}
