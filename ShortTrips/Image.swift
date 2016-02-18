//
//  Image.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/29/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit

enum Image: String {
  
  // auth
  case blueGradient = "blue_gradient_bg"
  case sfoLogoAndName = "sfo_logo2"
  
  case sfoLogoAlpha = "sfo_logo_alpha"
  
  case greenCircle = "green_circle"
  case blueCircle = "blue_circle"
  case redCircle = "red_circle"
  
  case minus = "minus"
  case minusPressed = "minus_pressed"
  case plus = "plus"
  case plusPressed = "plus_pressed"
  
  case indicatorArrow = "indicator_arrow"
  case downArrow = "down_arrow"
  case backButton = "backButton"
    
  case unknownAirline = "unknownAirline"
  
  case splashLogo = "splashLogo"
  
  // tab bar
  case dashboardIcon = "dashboard_icon"
  case flightsIcon = "flights_icon"
  case tripIcon = "trip_icon"
  
  case blackCircle = "black_circle"
  case whiteCircle = "white_circle"
  
  // TODO: remove when ring is real
  case greenRing = "green_ring"
  case yellowRing = "circle_yellow"
  case redRing = "circle_red"
  
  // Trip Prompts
  case map = "map"
  case mapPin = "pin"
  case car = "car"
  case checkmark = "check"
  case card = "card"
  case exclamation = "exclamation"
  case gear = "gear"
  case taxi = "taxi"
  case bgCircles = "bg_circles"
  
  func image() -> UIImage {
    return UIImage(named: self.rawValue)!
  }
  
  static func from(color: UIColor) -> UIImage {
    let rect = CGRectMake(0, 0, 1, 1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    CGContextSetFillColorWithColor(context, color.CGColor)
    CGContextFillRect(context, rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
}
