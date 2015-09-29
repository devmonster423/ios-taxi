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
    static let fontNormal = Font.MyriadProBold.size(30)
    static let fontSmall = Font.MyriadProBold.size(20)
  }
  
  struct FlightCell {
    static let fontNormal = Font.MyriadProSemibold.size(15)
    static let fontSmallish = Font.MyriadProSemibold.size(11)
    static let fontSmall = Font.MyriadProSemibold.size(10)
    static let standardMargin = 5.0
    static let bigMargin = 10.0
    static let rowHeight: CGFloat = 80.0
    static let airlineIconWidth: CGFloat = 0.15
    static let airlineAndFlightWidth: CGFloat = 0.30
    static let timesTitleWidth: CGFloat = 0.22
    static let timesWidth: CGFloat = 0.18
    static let statusWidth: CGFloat = 0.15
    static let statusPadding: CGFloat = 2.0
    static let iPhone5Width: CGFloat = 320.0
    static let separatorHeight: CGFloat = 2.0
  }
}
