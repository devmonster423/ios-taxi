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
    
    switch validationStep {
    case .Valid:
      backgroundColor = Color.Trip.Notification.green
      notificationLabel.text = NSLocalizedString("Your trip finished and it was short.", comment: "")
      notificationImageView.image = Image.blueCheckmark.image()
      
    case .Duration:
      notificationLabel.text = NSLocalizedString("Time Expired", comment: "")
      
    default:
      backgroundColor = Color.Trip.Notification.red
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
