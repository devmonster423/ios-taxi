//
//  UiConstants.swift
//  ShortTrips
//
//  Created by Josh Adams on 7/27/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit

class UiConstants {
  class var statusColorGreen: UIColor {
    return UIColor(red: 21/255.0,
      green: 155/255.0,
      blue: 32/255.0,
      alpha: 1.0)
  }
  class var statusColorYellow: UIColor {
    return UIColor(red: 233/255.0,
      green: 181/255.0,
      blue: 46/255.0,
      alpha: 1.0)
  }
  class var statusColorRed: UIColor {
    return UIColor(red: 242/255.0,
      green: 40/255.0,
      blue: 41/255.0,
      alpha: 1.0)
  }
  class var SfoColor: UIColor {
    return UIColor(red: 74.0/255.0,
      green: 144.0/255.0,
      blue: 255.0/255.0,
      alpha: 1.0)
  }
  class var SfoColorWithAlpha: UIColor {
    return UIColor(red: 74.0/255.0,
      green: 144.0/255.0,
      blue: 255.0/255.0,
      alpha: 0.5)
  }
  class var onTimeColor: UIColor {
    return UIColor(red: 74.0/255.0,
      green: 144.0/255.0,
      blue: 255.0/255.0,
      alpha: 1.0)
  }
  class var delayedColor: UIColor {
    return UIColor(red: 208.0/255.0,
      green: 2.0/255.0,
      blue: 27.0/255.0,
      alpha: 1.0)
  }
  class var landingColor: UIColor {
    return UIColor(red: 126.0/255.0,
      green: 211.0/255.0,
      blue: 33.0/255.0,
      alpha: 1.0)
  }
  class var landedColor: UIColor {
    return UIColor(red: 74.0/255.0,
      green: 74.0/255.0,
      blue: 74.0/255.0,
      alpha: 1.0)
  }

  class var statusCornerRadius: CGFloat { return 15.0 }
  class var statusBorderWidth: CGFloat { return 1.0 }
  class var fadeDuration: NSTimeInterval { return 1.0 }
  class var disabledWidgetAlpha: CGFloat { return 0.3 }
  class var backgroundCellHeight: CGFloat { return 200.0 }
  class var flightCellHeight: CGFloat { return 80.0 }
  class var updatePeriod: Int { return 300 }
  class var updateInterval: NSTimeInterval { return 1.0 }
  class var navControllerFont: String { return "MyriadPro-Bold" }
  class var navControllerFontSizeNormal: CGFloat { return 30.0 }
  class var navControllerFontSizeSmall: CGFloat { return 20.0 }
}
