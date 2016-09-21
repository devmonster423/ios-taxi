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
  class func disableWidgetWithAnimation(_ widget: UIView) {
    UIView.animate(withDuration: UiConstants.Fader.fadeDuration, animations: { () -> Void in
      widget.alpha = UiConstants.Fader.disabledWidgetAlpha
      if let widget = widget as? UIControl {
        widget.isEnabled = false
      }
    })
  }

  class func enableWidgetWithAnimation(_ widget: UIView) {
    if widget is UIControl {
      (widget as! UIControl).isEnabled = true
    }
    UIView.animate(withDuration: UiConstants.Fader.fadeDuration, animations: { () -> Void in
      widget.alpha = 1.0
      if let widget = widget as? UIControl {
        widget.isEnabled = true
      }
    })
  }
  
  class func displayComingSoonMessage(_ viewController: UIViewController) {
    displayMessage(viewController, title: NSLocalizedString("Coming Soon!", comment: ""), message: "")
  }
  
  class func displayErrorMessage(_ viewController: UIViewController, message: String) {
    displayMessage(viewController, title: NSLocalizedString("Error", comment: ""), message: message)
  }
  
  class func displayMessage(_ viewController: UIViewController, title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""),
      style: .default, handler: nil)
    alertController.addAction(OKAction)
    viewController.present(alertController, animated: true, completion: nil)
  }
}
