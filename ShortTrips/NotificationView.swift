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
      make.centerX.equalTo(self)
      make.width.equalTo(self).dividedBy(3)
      make.height.equalTo(self.snp_width).dividedBy(3)
      make.top.equalTo(notificationLabel.snp_bottom).offset(UiConstants.Trip.dividerMargin)
    }
  }
  
  func notifySuccess() {
    backgroundColor = Color.Trip.Notification.green
    notificationLabel.font = Font.OpenSansSemibold.size(25)
    notificationLabel.text = NSLocalizedString("The trip has ended and was recorded as a valid short trip.", comment: "").uppercaseString
    notificationImageView.image = Image.greenCheckmark.image()
    notificationImageView.alpha = 1
    Speaker.sharedInstance.speak(NSLocalizedString("Valid short trip.", comment: ""))
    
    resetLabelConstraints()
  }
  
  func resetLabelConstraints() {
    notificationLabel.snp_remakeConstraints { make in
      make.leading.equalTo(self).offset(UiConstants.Trip.Notification.offset)
      make.trailing.equalTo(self).offset(-UiConstants.Trip.Notification.offset)
      make.top.equalTo(self).offset(UiConstants.Trip.topMargin)
      make.height.equalTo(self).dividedBy(3)
    }
    
    notificationLabel.setNeedsUpdateConstraints()
    self.layoutIfNeeded()
  }
  
  func notifyFail(validationStep: ValidationStep, delay: NSTimeInterval, duration: NSTimeInterval) {
    
    resetLabelConstraints()
    
    notificationLabel.font = Font.OpenSansSemibold.size(18)
    var notificationText = NSLocalizedString("Your trip is now a long", comment: "") + "\n"
    
    switch validationStep {
    case .Duration:
      notificationText += NSLocalizedString("The trip has ended and was recorded as a long trip. The duration exceeded two hours.", comment: "")
      Speaker.sharedInstance.speak(NSLocalizedString("Long trip. Duration exceeded two hours.", comment: ""))
    case .Vehicle:
      notificationText += NSLocalizedString("The trip has ended and was recorded as a long trip. The vehicle at the start was not the same at the end of the trip.", comment: "")
      Speaker.sharedInstance.speak(NSLocalizedString("Long trip. Vehicle mismatch.", comment: ""))
    case .DriverCardId:
      notificationText += NSLocalizedString("The trip has ended and was recorded as a long trip. The card tapped at the start was not identified at the end of the trip.", comment: "")
      Speaker.sharedInstance.speak(NSLocalizedString("Long trip. Card error.", comment: ""))
    case .MacAddress:
      notificationText += NSLocalizedString("The trip has ended and was recorded as a long trip. The phone at the start was not identified at the end of the trip.", comment: "")
      Speaker.sharedInstance.speak(NSLocalizedString("Long trip. Phone error.", comment: ""))
    case .Geofence:
      notificationText += NSLocalizedString("The trip has ended and was recorded as a long trip. The vehicle was located outside the geofence while trip was in progress.", comment: "")
      Speaker.sharedInstance.speak(NSLocalizedString("Long trip. Outside geofence.", comment: ""))      
    case .GpsFailure:
      notificationText += NSLocalizedString("The trip has ended and was recorded as a long trip. Location-based services were unavailable while the trip was in progress.", comment: "")
      Speaker.sharedInstance.speak(NSLocalizedString("Long trip. Location services unavailable.", comment: ""))
    case .UserLogout:
      notificationText += NSLocalizedString("The trip has ended and was recorded as a long trip. Logout occurred while the trip was in progress.", comment: "")
      Speaker.sharedInstance.speak(NSLocalizedString("Long trip. User logged out.", comment: ""))
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
    notificationImageView.image = Image.exclamationPoint.image()
    
    Speaker.sharedInstance.speak(notificationLabel.text!)
    
    notificationLabel.snp_remakeConstraints { make in
      make.leading.equalTo(self).offset(UiConstants.Trip.Notification.offset)
      make.trailing.equalTo(self).offset(-UiConstants.Trip.Notification.offset)
      make.top.equalTo(self).offset(UiConstants.Trip.topMargin)
      make.height.equalTo(self).offset(-(2*UiConstants.Trip.topMargin))
    }
    
    notificationImageView.alpha = 1
    notificationLabel.setNeedsUpdateConstraints()
    UIView.animateWithDuration(duration,
      delay: delay,
      options: UIViewAnimationOptions.CurveEaseInOut,
      animations: {
        self.layoutIfNeeded()
        self.notificationImageView.alpha = 0
      },
      completion: nil)
  }
}
