//
//  UiConstants.swift
//  ShortTrips
//
//  Created by Josh Adams on 7/27/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit

struct UiConstants {
  struct Dashboard {
    static let statusCornerRadius: CGFloat = 15.0
    static let statusBorderWidth: CGFloat = 1.0
    static let buttonBgOffset: CGFloat = -10.0
    static let overlayAlpha: CGFloat = 0.05
    static let fullnessFontSize: CGFloat = 48.0
    static let fullnessLabelFontSize: CGFloat = 29.0
    static let progressHeight: CGFloat = 50.0
    static let terminalStatusFontSize: CGFloat = 17.0
    static let terminalStatusWidth: CGFloat = 200.0
    static let terminalStatusHeight: CGFloat = 60.0
    static let buttonTimerOffset: CGFloat = -10.0
  }
  
  struct Fader {
    static let fadeDuration: NSTimeInterval = 1.0
    static let disabledWidgetAlpha: CGFloat = 0.3
  }
  
  struct Timer {
    static let updatePeriod: Int = 300
    static let updateInterval: NSTimeInterval = 1.0
    static let progressHeight: CGFloat = 10.0
    static let updateHeight: CGFloat = 13.0
    static let bottomOffset: CGFloat = -5.0
  }
  
  struct NavController {
    static let font: String = "MyriadPro-Bold"
    static let fontSizeNormal: CGFloat = 30.0
    static let fontSizeSmall: CGFloat = 20.0
  }
}
