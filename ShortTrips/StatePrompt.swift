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
  case TurnOnGps
  case GoToSfo
  case Pay
  case Ready
  case InProgress
  
  func visualString() -> String {
    switch self {
    case .TurnOnGps:
      return NSLocalizedString("Allow this app to use your location", comment: "").uppercaseString
    case .GoToSfo:
      return NSLocalizedString("Go to SFO holding lot to start your next trip", comment: "").uppercaseString
    case .Pay:
      return NSLocalizedString("Pay and go to terminal curbside to start your next trip", comment: "").uppercaseString
    case .Ready:
      return NSLocalizedString("Your trip will start when you exit the airport", comment: "").uppercaseString
    case .InProgress:
      return NSLocalizedString("Your short trip is in progress", comment: "").uppercaseString
    }
  }
  
  func audioString() -> String {
    switch self {
    case .TurnOnGps:
      return NSLocalizedString("Go to your phone's Settings app. Select Privacy, then Location Services, and allow this app to use your location", comment: "")
    default:
      return visualString()
    }
  }
  
  func image() -> UIImage {
    switch self {
    case .TurnOnGps:
      return Image.exclamationPoint.image()
    case .GoToSfo:
      return Image.exclamationPoint.image()
    case .Pay:
      return Image.exclamationPoint.image()
    case .Ready:
      return Image.mapPin.image()
    case .InProgress:
      return Image.car.image()
    }
  }
}
