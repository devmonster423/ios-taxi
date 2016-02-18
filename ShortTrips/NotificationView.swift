//
//  NotificationView.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/11/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class NotificationView: UIView {

  private let notificationLabel = UILabel()
  private let notificationImageView = UIImageView()

  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  
    addSubview(notificationLabel)
    addSubview(notificationImageView)
    
    notificationLabel.numberOfLines = 0
    notificationLabel.textAlignment = .Center
    notificationLabel.textColor = Color.Trip.title
    
    notificationImageView.contentMode = .ScaleAspectFit
    notificationImageView.snp_makeConstraints { make in
      make.leading.equalTo(self).offset(50)
      make.trailing.equalTo(self).offset(-50)
      make.top.equalTo(notificationLabel.snp_bottom)
      make.bottom.equalTo(self).offset(-50)
      make.height.equalTo(self).dividedBy(Util.isIphone4() ? 3 : 2).priorityLow()
    }
  }
  
  func notifySuccess() {
    backgroundColor = Color.Trip.Notification.green
    notificationLabel.font = Font.OpenSansSemibold.size(30)
    notificationLabel.text = NSLocalizedString("Valid short trip", comment: "").uppercaseString
    notificationImageView.image = Image.checkmark.image()
    notificationImageView.alpha = 1
    Speaker.sharedInstance.speak(NSLocalizedString("The trip has ended and was recorded as a valid short trip.", comment: ""))
    
    resetLabelConstraints()
  }
  
  func resetLabelConstraints() {
    notificationLabel.snp_remakeConstraints { make in
      make.leading.equalTo(self).offset(25)
      make.trailing.equalTo(self).offset(-25)
      make.top.equalTo(self).offset(UiConstants.Trip.topMargin)
    }
    
    notificationLabel.setNeedsUpdateConstraints()
    self.layoutIfNeeded()
  }
  
  func notifyFail(validationStep: ValidationStep, delay: NSTimeInterval, duration: NSTimeInterval) {
    notificationLabel.font = Font.OpenSansSemibold.size(30)
    resetLabelConstraints()
    var notificationText = ""
    switch validationStep {
    case .Duration:
      notificationText += NSLocalizedString("Long trip.\nDuration exceeded two hours.", comment: "")
      Speaker.sharedInstance.speak(NSLocalizedString("The trip has ended and was recorded as a long trip. The duration exceeded two hours.", comment: ""))
    case .Vehicle:
      notificationText += NSLocalizedString("Long trip.\nVehicle mismatch.", comment: "")
      Speaker.sharedInstance.speak(NSLocalizedString("The trip has ended and was recorded as a long trip. The vehicle at the start was not the same at the end of the trip.", comment: ""))
    case .DriverCardId:
      notificationText += NSLocalizedString("Long trip.\nCard error.", comment: "")
      Speaker.sharedInstance.speak(NSLocalizedString("The trip has ended and was recorded as a long trip. The card tapped at the start was not identified at the end of the trip.", comment: ""))
    case .MacAddress:
      notificationText += NSLocalizedString("Long trip.\nPhone error.", comment: "")
      Speaker.sharedInstance.speak(NSLocalizedString("The trip has ended and was recorded as a long trip. The phone at the start was not identified at the end of the trip.", comment: ""))
    case .Geofence:
      notificationText += NSLocalizedString("Long trip.\nOutside geofence.", comment: "")
      Speaker.sharedInstance.speak(NSLocalizedString("The trip has ended and was recorded as a long trip. The vehicle was located outside the geofence while trip was in progress.", comment: ""))
    case .GpsFailure:
      notificationText += NSLocalizedString("Long trip.\nLocation services unavailable.", comment: "")
      Speaker.sharedInstance.speak(NSLocalizedString("The trip has ended and was recorded as a long trip. Location based services were unavailable while the trip was in progress.", comment: ""))
    case .UserLogout:
      notificationText += NSLocalizedString("Long trip.\nUser logged out.", comment: "")
      Speaker.sharedInstance.speak(NSLocalizedString("The trip has ended and was recorded as a long trip. Logout occurred while the trip was in progress.", comment: ""))
    case .AppQuit:
      notificationText += NSLocalizedString("App quit", comment: "")
    case .AppCrash:
      notificationText += NSLocalizedString("App crash", comment: "")
    case .NetworkFailure:
      notificationText += NSLocalizedString("Network failure", comment: "")
    default:
      break
    }
    backgroundColor = Color.Trip.Notification.red
    notificationLabel.text = notificationText.uppercaseString
    notificationImageView.image = Image.exclamation.image()
    Speaker.sharedInstance.speak(notificationLabel.text!)
    notificationLabel.snp_remakeConstraints { make in
      make.leading.equalTo(self).offset(UiConstants.Trip.Notification.offset)
      make.trailing.equalTo(self).offset(-UiConstants.Trip.Notification.offset)
      make.top.equalTo(self)
      make.height.equalTo(self)
    }
    notificationImageView.alpha = 1
    notificationLabel.setNeedsUpdateConstraints()
    UIView.animateWithDuration(duration,
      delay: delay,
      options: UIViewAnimationOptions.CurveEaseInOut,
      animations: {
        self.layoutIfNeeded()
        self.notificationLabel.alpha = 0
        self.notificationImageView.alpha = 0
      },
      completion: { completed in
        self.notificationLabel.font = Font.OpenSansSemibold.size(15)
        
        UIView.animateWithDuration(duration,
          animations: {
            self.notificationLabel.alpha = 1
          },
          completion: nil)
    })
  }
}
