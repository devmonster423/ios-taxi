//
//  Color.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit

struct Color {
  struct StatusColor {
    static let green = UIColor(red: 21/255.0, green: 155/255.0, blue: 32/255.0, alpha: 1.0)
    static let yellow = UIColor(red: 233/255.0, green: 181/255.0, blue: 46/255.0, alpha: 1.0)
    static let red = UIColor(red: 242/255.0, green: 40/255.0, blue: 41/255.0, alpha: 1.0)
  }
  
  struct Sfo {
    static let blue = UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static let blueWithAlpha = UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 255.0/255.0, alpha: 0.5)
  }
  
  struct FlightStatus {
    static let onTime = UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static let delayed = UIColor(red: 208.0/255.0, green: 2.0/255.0, blue: 27.0/255.0, alpha: 1.0)
    static let landing = UIColor(red: 126.0/255.0, green: 211.0/255.0, blue: 33.0/255.0, alpha: 1.0)
    static let landed = UIColor(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 1.0)
  }
}
