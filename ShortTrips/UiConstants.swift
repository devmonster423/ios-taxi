//
//  UiConstants.swift
//  ShortTrips
//
//  Created by Josh Adams on 7/27/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit

class UiConstants {
  class var statusCornerRadius: CGFloat { return 15.0 }
  class var statusBorderWidth: CGFloat { return 1.0 }
  class var backgroundCellHeight: CGFloat { return 100.0 }
  class var flightCellHeight: CGFloat { return 80.0 }
  class var timeTolerance: Float { return 0.25 }
  class var updatePeriod: Int { return 300 }
  class var updateInterval: NSTimeInterval { return 1.0 }
  class var SfoColor: CGColor { return CGColorCreate(CGColorSpaceCreateDeviceRGB(), [74.0 / 255.0, 144.0 / 255.0, 255.0 / 255.0, 1.0]) }
  class var onTimeColor: CGColor { return CGColorCreate(CGColorSpaceCreateDeviceRGB(), [74.0 / 255.0, 144.0 / 255.0, 255.0 / 255.0, 1.0]) }
  class var delayedColor: CGColor { return CGColorCreate(CGColorSpaceCreateDeviceRGB(), [208.0 / 255.0, 2.0 / 255.0, 27.0 / 255.0, 1.0]) }
  class var landingColor: CGColor { return CGColorCreate(CGColorSpaceCreateDeviceRGB(), [126.0 / 255.0, 211.0 / 255.0, 33.0 / 255.0, 1.0]) }
  class var landedColor: CGColor { return CGColorCreate(CGColorSpaceCreateDeviceRGB(), [74.0 / 255.0, 74.0 / 255.0, 74.0 / 255.0, 1.0]) }
}
