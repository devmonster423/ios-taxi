//
//  ShortTripView.swift
//  ShortTrips
//
//  Created by Joshua Adams on 11/24/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit
import SnapKit

enum StatePrompt {
  case GoToSfo
  case Pay
  case Ready
  case InProgress
  
  func toString() -> String {
    switch self {
    case .GoToSfo:
      return NSLocalizedString("Go to SFO holding lot to start your next trip", comment: "").uppercaseString
    case .Pay:
      return NSLocalizedString("Pay and go to terminal curbside to start your next trip", comment: "").uppercaseString
    case .Ready:
      return NSLocalizedString("Your trip will start when you exit the airport", comment: "").uppercaseString
    case .InProgress:
      return NSLocalizedString("Your short trip is in progress", comment: "").uppercaseString
    }
  }
  
  func image() -> UIImage {
    switch self {
    case .GoToSfo:
      return Image.exclamationPoint.image()
    case .Pay:
      return Image.exclamationPoint.image()
    case .Ready:
      return Image.mapPin.image()
    case .InProgress:
      return Image.car.image()
    }
  }
}

class ShortTripView: UIView {
  let countdownLabel = UILabel()
  let countdownSubtitleLabel = UILabel()
  private let promptLabel = UILabel()
  private let promptImageView = UIImageView()
  private let notificationView = NotificationView()
  private var currentPrompt: StatePrompt?
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.whiteColor()
    
    addSubview(countdownLabel)
    addSubview(countdownSubtitleLabel)
    addSubview(promptLabel)
    addSubview(promptImageView)
    
    countdownLabel.backgroundColor = Color.Trip.Time.background
    countdownLabel.font = Font.OpenSans.size(28)
    countdownLabel.textAlignment = .Center
    countdownLabel.textColor = Color.Trip.Time.title
    countdownLabel.snp_makeConstraints { make in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self)
      make.height.equalTo(150)
    }
    
    countdownSubtitleLabel.font = Font.OpenSans.size(24)
    countdownSubtitleLabel.text = NSLocalizedString("Time Remaining", comment: "").uppercaseString
    countdownSubtitleLabel.textAlignment = .Center
    countdownSubtitleLabel.textColor = Color.Trip.Time.subtitle
    countdownSubtitleLabel.snp_makeConstraints { make in
      make.leading.equalTo(countdownLabel)
      make.trailing.equalTo(countdownLabel)
      make.bottom.equalTo(countdownLabel)
      make.height.equalTo(40)
    }
    
    let horizontalDivider = UIView()
    horizontalDivider.backgroundColor = Color.Trip.divider
    addSubview(horizontalDivider)
    horizontalDivider.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(self)
      make.height.equalTo(1)
      make.width.equalTo(self).dividedBy(2)
      make.bottom.equalTo(promptImageView.snp_top).offset(-UiConstants.Trip.verticalMargin)
    }
    
    promptLabel.font = Font.OpenSansBold.size(28)
    promptLabel.textAlignment = .Center
    promptLabel.numberOfLines = 0
    promptLabel.textColor = Color.Trip.title
    promptLabel.snp_makeConstraints { make in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.height.equalTo(75)
      make.bottom.equalTo(horizontalDivider.snp_top).offset(-UiConstants.Trip.verticalMargin)
    }
    
    promptImageView.contentMode = .ScaleAspectFit
    promptImageView.snp_makeConstraints { make in
      make.center.equalTo(self)
      make.width.equalTo(200)
      make.height.equalTo(200)
    }
    
    addSubview(notificationView)
    notificationView.hidden = true
  }
  
  func updatePrompt(prompt: StatePrompt) {
    if prompt != currentPrompt {
      promptLabel.text = prompt.toString()
      promptImageView.image = prompt.image()
      Speaker.speak(prompt.toString())
  
      currentPrompt = prompt
    }
  }
  
  func notifySuccess() {
    
    notificationView.snp_remakeConstraints { make in
      make.height.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self)
    }
    notificationView.setNeedsUpdateConstraints()
    layoutIfNeeded()
    
    notificationView.notifySuccess()
    notificationView.hidden = false
  }
  
  func notifyFail(validationStep: ValidationStep) {
    
    notificationView.snp_remakeConstraints { make in
      make.height.equalTo(self).multipliedBy(0.75)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self)
    }
    notificationView.setNeedsUpdateConstraints()
    layoutIfNeeded()
    
    let duration: NSTimeInterval = 0.5
    let delay: NSTimeInterval = 5
    
    notificationView.notifyFail(validationStep, delay: delay, duration: duration)
    
    notificationView.snp_remakeConstraints { make in
      make.height.equalTo(self).multipliedBy(0.25)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self)
    }
    
    notificationView.setNeedsUpdateConstraints()
    notificationView.hidden = false
    UIView.animateWithDuration(duration,
      delay: delay,
      options: UIViewAnimationOptions.CurveEaseInOut,
      animations: {
        self.layoutIfNeeded()
      },
      completion: nil)
  }
  
  func hideNotification() {
    notificationView.hidden = true
  }
}
