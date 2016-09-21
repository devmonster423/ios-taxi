//
//  StatePrompt.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/22/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import UIKit

enum StatePrompt {
  case turnOnGps
  case goToSfo
  case pay
  case ready
  case inProgress
  
  func visualString() -> String {
    switch self {
    case .turnOnGps:
      return NSLocalizedString("Location Services Required", comment: "").uppercased()
    case .goToSfo:
      return NSLocalizedString("SFO Garage Entry Required Prior to Next Trip", comment: "").uppercased()
    case .pay:
      return NSLocalizedString("Waiting for dispatch", comment: "").uppercased()
    case .ready:
      return NSLocalizedString("Trip Pending Until Exit From SFO", comment: "").uppercased()
    case .inProgress:
      return NSLocalizedString("Trip In Progress", comment: "").uppercased()
    }
  }
  
  func audioString() -> String {
    switch self {
    case .turnOnGps:
      return NSLocalizedString("Location services must be turned on in order to monitor your trip.", comment: "")
    case .inProgress:
      return NSLocalizedString("The trip has started and will be monitored.", comment: "")
    case .ready:
      return NSLocalizedString("The trip will start when the vehicle exits SFO.", comment: "")
    case .pay:
      return NSLocalizedString("Waiting for dispatch", comment: "")
    default:
      return visualString()
    }
  }
  
  func image() -> UIImage {
    switch self {
    case .turnOnGps:
      return Image.map.image()
    case .goToSfo:
      return Image.map.image()
    case .pay:
      return Image.hourglass.image()
    case .ready:
      return Image.mapPin.image()
    case .inProgress:
      return Image.car.image()
    }
  }
}
