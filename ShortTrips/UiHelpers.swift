//
//  UiHelpers.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/25/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import UIKit

class UiHelpers {
  class func disableWidgetWithAnimation(widget: UIView) {
    UIView.animateWithDuration(UiConstants.fadeDuration, animations: { () -> Void in
      widget.alpha = UiConstants.disabledWidgetAlpha
      if widget is UIControl {
        (widget as! UIControl).enabled = false
      }
    })
  }

  class func enableWidgetWithAnimation(widget: UIView) {
    if widget is UIControl {
      (widget as! UIControl).enabled = true
    }
    UIView.animateWithDuration(UiConstants.fadeDuration, animations: { () -> Void in
      widget.alpha = 1.0
      if widget is UIControl {
        (widget as! UIControl).enabled = true
      }
    })
  }
}