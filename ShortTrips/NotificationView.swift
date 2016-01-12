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
      make.height.equalTo(self).dividedBy(3)
    }
    
    notificationImageView.contentMode = .ScaleAspectFit
    notificationImageView.snp_makeConstraints { make in
      make.centerX.equalTo(self)
      make.width.equalTo(self).dividedBy(3)
      make.height.equalTo(self.snp_width).dividedBy(3)
      make.top.equalTo(notificationLabel.snp_bottom).offset(UiConstants.Trip.Notification.offset)
    }
  }
  
  func notify(validationStep: ValidationStep, delay: NSTimeInterval, duration: NSTimeInterval) {
    
    if validationStep == .Valid {
      backgroundColor = Color.Trip.Notification.green
      notificationLabel.text = NSLocalizedString("Your trip finished and it was short.", comment: "")
      notificationImageView.image = Image.blueCheckmark.image()
      
    } else {
      
      var notificationText = NSLocalizedString("Your trip is now a long.", comment: "") + " "
      
      if validationStep == .Duration {
        notificationText += NSLocalizedString("Time expired.", comment: "")
        
      } else if validationStep == .Vehicle {
        notificationText += NSLocalizedString("Vehicle mismatch.", comment: "")
        
      } else if validationStep == .DriverCardId {
        notificationText += NSLocalizedString("Card error.", comment: "")
        
      } else if validationStep == .MacAddress {
        notificationText += NSLocalizedString("Phone error.", comment: "")
        
      } else if validationStep == .Geofence {
        notificationText += NSLocalizedString("Outside short trip geofence.", comment: "")
        
      } else if validationStep == .GpsFailure {
        notificationText += NSLocalizedString("GPS off.", comment: "")
        
      } else if validationStep == .NetworkFailure {
        notificationText += NSLocalizedString("Network failure.", comment: "")
        
      } else if validationStep == .UserLogout {
        notificationText += NSLocalizedString("User logout.", comment: "")
        
      } else if validationStep == .AppQuit {
        notificationText += NSLocalizedString("App quit.", comment: "")
        
      } else if validationStep == .AppCrash {
        notificationText += NSLocalizedString("App crash.", comment: "")
      }
      
      backgroundColor = Color.Trip.Notification.red
      notificationLabel.text = notificationText
      notificationImageView.image = Image.exclamationPoint.image()
    }
    
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
