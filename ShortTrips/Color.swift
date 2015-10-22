//
//  Color.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit

struct Color {
  
  struct Debug {
    static let green = StatusColor.green
    static let red = StatusColor.red
  }
  
  struct NavBar {
    static let subtitleBlue = UIColor(red: 0.0/255.0, green: 132.0/255.0, blue: 187.0/255.0, alpha: 1.0)
  }
  
  struct StatusColor {
    static let green = UIColor(red: 21/255.0, green: 155/255.0, blue: 32/255.0, alpha: 1.0)
    static let yellow = UIColor(red: 233/255.0, green: 181/255.0, blue: 46/255.0, alpha: 1.0)
    static let red = UIColor(red: 242/255.0, green: 40/255.0, blue: 41/255.0, alpha: 1.0)
  }
  
  struct Sfo {
    static let blue = UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 1.0)
    static let blueWithAlpha = UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 0.5)
    static let gray = UIColor(red: 115.0/255.0, green: 115.0/255.0, blue: 115.0/255.0, alpha: 1.0)
    static let turquoise = UIColor(red: 26.0/255.0, green: 120.0/255.0, blue: 167.0/255.0, alpha: 1.0)
    static let lightBlue = UIColor(red: 150.0/255.0, green: 184.0/255.0, blue: 241.0/255.0, alpha: 1.0)
  }
  
  struct TerminalSummary {
    static let offWhite = UIColor(red: 244.0/255.0, green: 246.0/255.0, blue: 243.0/255.0, alpha: 1.0)
    static let titleBlue = UIColor(red: 66/255.0, green: 117/255.0, blue: 164/255.0, alpha: 1.0)
    static let onTimeContent = Sfo.blue
    static let onTimeTitle = titleBlue
    static let delayedContent = UIColor(red: 208/255.0, green: 2/255.0, blue: 27/255.0, alpha: 1.0)
    static let delayedTitle = FlightStatus.delayed
    static let darkBackground = UIColor(red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 0.15)
    static let separator = UIColor(red: 29/255.0, green: 29/255.0, blue: 38/255.0, alpha: 0.1)
  }
  
  struct FlightStatus {
    static let standard = UIColor(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 1.0)
    static let onTime = UIColor(red: 7.0/255.0, green: 104.0/255.0, blue: 147.0/255.0, alpha: 1.0)
    static let delayed = UIColor(red: 195.0/255.0, green: 32.0/255.0, blue: 38.0/255.0, alpha: 1.0)
    static let landing = UIColor(red: 126.0/255.0, green: 211.0/255.0, blue: 33.0/255.0, alpha: 1.0)
    static let landed = standard
    static let separator = UIColor(red: 229.0/255.0, green: 229.0/255.0, blue: 229.0/255.0, alpha: 1.0)
    static let tableHeader = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
  }

  struct FlightCell {
    static let darkBackground = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
    static let lightBackground = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
  }
}
