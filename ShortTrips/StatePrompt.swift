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
      return NSLocalizedString("Location services must be turned on in order to monitor your trip.", comment: "").uppercaseString
    case .GoToSfo:
      return NSLocalizedString("Go to SFO holding lot to start your next trip", comment: "").uppercaseString
    case .Pay:
      return NSLocalizedString("Dispatch to the curbside occurs after payment is made.", comment: "").uppercaseString
    case .Ready:
      return NSLocalizedString("The trip will start when the vehicle exits SFO.", comment: "").uppercaseString
    case .InProgress:
      return NSLocalizedString("The trip has started and will be monitored.", comment: "").uppercaseString
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
      return Image.map.image()
    case .GoToSfo:
      return Image.map.image()
    case .Pay:
      return Image.map.image()
    case .Ready:
      return Image.mapPin.image()
    case .InProgress:
      return Image.car.image()
    }
  }
}
