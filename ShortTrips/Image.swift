//
//  Image.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/29/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit

enum Image: String {
  
  case greenCircle = "green_circle"
  case blueCircle = "blue_circle"
  case redCircle = "red_circle"
  
  case navbarBlue = "navbar_blue"
  
  case unknownAirline = "unknownAirline"
  
  func image() -> UIImage {
    return UIImage(named: self.rawValue)!
  }
}
