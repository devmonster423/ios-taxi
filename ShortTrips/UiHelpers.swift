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
    UIView.animateWithDuration(UiConstants.Fader.fadeDuration, animations: { () -> Void in
      widget.alpha = UiConstants.Fader.disabledWidgetAlpha
      if let widget = widget as? UIControl {
        widget.enabled = false
      }
    })
  }

  class func enableWidgetWithAnimation(widget: UIView) {
    if widget is UIControl {
      (widget as! UIControl).enabled = true
    }
    UIView.animateWithDuration(UiConstants.Fader.fadeDuration, animations: { () -> Void in
      widget.alpha = 1.0
      if let widget = widget as? UIControl {
        widget.enabled = true
      }
    })
  }
  
  class func displayErrorMessage(viewController: UIViewController, message: String) {
    displayMessage(viewController, title: NSLocalizedString("Error", comment: ""), message: message)
  }
  
  class func displayMessage(viewController: UIViewController, title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    let OKAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""),
      style: .Default, handler: nil)
    alertController.addAction(OKAction)
    viewController.presentViewController(alertController, animated: true, completion: nil)
  }
}