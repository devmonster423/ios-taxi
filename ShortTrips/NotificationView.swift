//
//  File.swift
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
    
    notificationLabel.font = Font.MyriadPro.size(20)
    notificationLabel.numberOfLines = 0
    notificationLabel.textAlignment = .Center
    notificationLabel.textColor = UIColor.whiteColor()
    notificationLabel.snp_makeConstraints { make in
      make.leading.equalTo(self).offset(UiConstants.Trip.Notification.offset)
      make.trailing.equalTo(self).offset(-UiConstants.Trip.Notification.offset)
      make.top.equalTo(self).offset(UiConstants.Trip.Notification.offset)
      make.height.equalTo(self).dividedBy(2)
    }
    
    notificationImageView.contentMode = .ScaleAspectFit
    notificationImageView.snp_makeConstraints { make in
      make.centerX.equalTo(self)
      make.width.equalTo(self).dividedBy(3)
      make.height.equalTo(self.snp_width).dividedBy(3)
      make.top.equalTo(notificationLabel.snp_bottom).offset(UiConstants.Trip.Notification.offset)
    }
  }
  
  func notifySuccess() {
    backgroundColor = Color.Trip.Notification.green
    notificationLabel.text = NSLocalizedString("Your trip finished and it was short.", comment: "")
    notificationImageView.image = Image.blueCheckmark.image()
    notificationImageView.alpha = 1
    Speaker.speak(notificationLabel.text!)
  }
  
  func notifyFail(validationStep: ValidationStep, delay: NSTimeInterval, duration: NSTimeInterval) {
      
    var notificationText = NSLocalizedString("Your trip is now a long.", comment: "") + " "
    
    switch validationStep {
    case .Duration:
      notificationText += NSLocalizedString("Time expired.", comment: "")
    case .Vehicle:
      notificationText += NSLocalizedString("Vehicle mismatch.", comment: "")
    case .DriverCardId:
      notificationText += NSLocalizedString("Card error.", comment: "")
    case .MacAddress:
      notificationText += NSLocalizedString("Phone error.", comment: "")
    case .Geofence:
      notificationText += NSLocalizedString("Outside short trip geofence.", comment: "")
    case .GpsFailure:
      notificationText += NSLocalizedString("GPS off.", comment: "")
    case .NetworkFailure:
      notificationText += NSLocalizedString("Network failure.", comment: "")
    case .UserLogout:
      notificationText += NSLocalizedString("User logout.", comment: "")
    case .AppQuit:
      notificationText += NSLocalizedString("App quit.", comment: "")
    case .AppCrash:
      notificationText += NSLocalizedString("App crash.", comment: "")
    default:
      break
    }
    
    backgroundColor = Color.Trip.Notification.red
    notificationLabel.text = notificationText
    notificationImageView.image = Image.exclamationPoint.image()
    
    Speaker.speak(notificationLabel.text!)
    
    notificationImageView.alpha = 1
    UIView.animateWithDuration(duration,
      delay: delay,
      options: UIViewAnimationOptions.CurveEaseInOut,
      animations: {
        self.notificationImageView.alpha = 0
      },
      completion: nil)
  }
}
