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
    static let progressHeight: CGFloat = 35.0
    static let buttonFontSize: CGFloat = 17.0
    static let terminalStatusWidth: CGFloat = 150.0
    static let shortTripWidth: CGFloat = 130.0
    static let buttonHeight: CGFloat = 60.0
    static let buttonTimerOffset: CGFloat = -10.0
    static let titleWidth: CGFloat = 60.0
    static let titleHeight: CGFloat = 30.0
    static let buttonMargin: CGFloat = 16.0
  }
  
  struct TerminalSummary {
    static let arrivalsDeparturesWidth: CGFloat = 100.0
    static let arrivalsDeparturesHeight: CGFloat = 40.0
    static let toggleFont = Font.OpenSansSemibold.size(20.0)
    static let fadeDuration: TimeInterval = 0.3
    static let grayViewAlpha: CGFloat = 0.5
  }
  
  struct FlightStatus {
    static let tableHeaderFont = Font.OpenSansSemibold.size(20.0)
    static let tableHeaderHeight: CGFloat = 40.0
  }
  
  struct Fader {
    static let fadeDuration: TimeInterval = 1.0
    static let disabledWidgetAlpha: CGFloat = 0.3
  }
  
  struct Timer {
    static let updatePeriod: Int = 300
    static let updateInterval: TimeInterval = 1.0
    static let progressHeight: CGFloat = 10.0
    static let updateHeight: CGFloat = 13.0
    static let bottomOffset: CGFloat = -3.0
  }
  
  struct NavController {
    static let fontNormal = Font.OpenSansBold.size(30)
    static let fontSmall = Font.OpenSansBold.size(20)
  }
  
  struct TabBarController {
    static let height = CGFloat(60.0)
  }
  
  struct ReachabilityNotice {
    static let height: CGFloat = 45
  }
  
  struct FlightCell {
    static let fontNormal = Font.OpenSansSemibold.size(14)
    static let fontSmallish = Font.OpenSansSemibold.size(11)
    static let fontSmall = Font.OpenSansSemibold.size(10)
    static let standardMargin = 5.0
    static let bigMargin = 10.0
    static let rowHeight: CGFloat = 80.0
    static let airlineIconWidth: CGFloat = 0.17
    static let timesTitleWidth: CGFloat = 0.20
    static let timesWidth: CGFloat = 0.17
    static let statusWidth: CGFloat = 0.17
    static let iPhone5Width: CGFloat = 320.0
    static let separatorHeight: CGFloat = 2.0
    static let statusImageDiameter: CGFloat = 10.0
    static let statusImageVerticalOffset: CGFloat = -2.0
  }
  
  struct Trip {
    static let topMargin: CGFloat = UIScreen.main.bounds.height / 20.0
    static let dividerMargin: CGFloat = 15.0
    
    struct Notification {
      static let offset: CGFloat = 25.0
    }
  }
}
