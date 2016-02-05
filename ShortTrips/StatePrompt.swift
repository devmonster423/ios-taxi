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
      return NSLocalizedString("Location Services Required", comment: "").uppercaseString
    case .GoToSfo:
      return NSLocalizedString("SFO Garage Entry Required Prior to Next Trip", comment: "").uppercaseString
    case .Pay:
      return NSLocalizedString("Payment Required For Curbside Pickup", comment: "").uppercaseString
    case .Ready:
      return NSLocalizedString("Trip Pending Until Exit From SFO", comment: "").uppercaseString
    case .InProgress:
      return NSLocalizedString("Trip In Progress", comment: "").uppercaseString
    }
  }
  
  func audioString() -> String {
    switch self {
    case .TurnOnGps:
      return NSLocalizedString("Location services must be turned on in order to monitor your trip.", comment: "")
    case .InProgress:
      return NSLocalizedString("The trip has started and will be monitored.", comment: "")
    case .Ready:
      return NSLocalizedString("The trip will start when the vehicle exits SFO.", comment: "")
    case .Pay:
      return NSLocalizedString("Dispatch to the curbside occurs after payment is made.", comment: "")
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
      return Image.card.image()
    case .Ready:
      return Image.mapPin.image()
    case .InProgress:
      return Image.car.image()
    }
  }
}
