//
//  ShortTripView.swift
//  ShortTrips
//
//  Created by Joshua Adams on 11/24/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit
import SnapKit

class ShortTripView: UIView {
  let countdown = CountdownView()
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
    
    addSubview(countdown)
    addSubview(promptLabel)
    addSubview(promptImageView)
    
    countdown.snp_makeConstraints { make in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self).offset(-20)
      make.height.equalTo(0)
    }
    
    promptLabel.font = Font.OpenSansSemibold.size(30)
    promptLabel.textAlignment = .Center
    promptLabel.numberOfLines = 0
    promptLabel.textColor = Color.Trip.title
    promptLabel.snp_makeConstraints { make in
      make.leading.equalTo(self).offset(25)
      make.trailing.equalTo(self).offset(-25)
      make.top.equalTo(self).offset(UiConstants.Trip.topMargin)
    }
    
    addSubview(notificationView)
    notificationView.hidden = true
    
    promptImageView.contentMode = .ScaleAspectFit
    promptImageView.snp_makeConstraints { make in
      make.leading.equalTo(self).offset(50)
      make.top.equalTo(promptLabel.snp_bottom)
      make.bottom.equalTo(countdown.snp_top)
      make.height.equalTo(self).dividedBy(Util.isIphone4Or5() ? 2.5 : 1.5).priorityLow()
      make.trailing.equalTo(self).offset(-50)
    }
    
    bringSubviewToFront(notificationView)
  }
  
  func updatePrompt(prompt: StatePrompt) {
    if prompt != currentPrompt {
      promptLabel.text = prompt.visualString()
      promptImageView.image = prompt.image()
      Speaker.sharedInstance.speak(prompt.audioString())
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
      make.height.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self)
    }
    
    promptImageView.snp_remakeConstraints { make in
      make.leading.equalTo(self).offset(50)
      make.top.equalTo(promptLabel.snp_bottom)
      make.bottom.equalTo(countdown.snp_top)
      make.height.equalTo(self).dividedBy(Util.isIphone4Or5() ? 2.5 : 1.5).priorityLow()
      make.trailing.equalTo(self).offset(-50)
    }
    
    notificationView.setNeedsUpdateConstraints()
    promptImageView.setNeedsUpdateConstraints()
    layoutIfNeeded()
    self.notificationView.hidden = false
    
    let duration: NSTimeInterval = 0.5
    let delay: NSTimeInterval = 5
    
    notificationView.notifyFail(validationStep, delay: delay, duration: duration)
    
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
      self.notificationView.snp_remakeConstraints { make in
        make.height.equalTo(self).dividedBy(9)
        make.leading.equalTo(self)
        make.trailing.equalTo(self)
        make.bottom.equalTo(self)
      }
      
      self.promptImageView.snp_remakeConstraints { make in
        make.leading.equalTo(self).offset(50)
        make.top.equalTo(self.promptLabel.snp_bottom).offset(20)
        make.bottom.equalTo(self.notificationView.snp_top).offset(-20)
        make.height.equalTo(self).dividedBy(Util.isIphone4Or5() ? 2.5 : 1.5).priorityLow()
        make.trailing.equalTo(self).offset(-50)
      }
      
      self.notificationView.setNeedsUpdateConstraints()
      self.promptImageView.setNeedsUpdateConstraints()
      UIView.animateWithDuration(duration,
        delay: 0,
        options: UIViewAnimationOptions.CurveEaseInOut,
        animations: {
          self.layoutIfNeeded()
        },
        completion: nil)
    }
  }
  
  func hideNotification() {
    promptImageView.snp_remakeConstraints { make in
      make.leading.equalTo(self).offset(50)
      make.top.equalTo(promptLabel.snp_bottom)
      make.bottom.equalTo(countdown.snp_top)
      make.height.equalTo(self).dividedBy(Util.isIphone4Or5() ? 2.5 : 1.5).priorityLow()
      make.trailing.equalTo(self).offset(-50)
    }
    promptImageView.setNeedsUpdateConstraints()
    self.layoutIfNeeded()
    notificationView.hidden = true
  }
  
  func updateCountdown(elapsedTime: NSTimeInterval?) {
    countdown.updateCountdown(elapsedTime)
  }
  
  func getPromptText() -> String? {
    return promptLabel.text
  }
  
  func toggleCountdown(visible: Bool) {
    if visible {
      countdown.snp_remakeConstraints { make in
        make.leading.equalTo(self)
        make.trailing.equalTo(self)
        make.bottom.equalTo(self).offset(-20)
        make.height.equalTo(self).dividedBy(7)
      }
    } else {
      countdown.snp_remakeConstraints { make in
        make.leading.equalTo(self)
        make.trailing.equalTo(self)
        make.bottom.equalTo(self).offset(-20)
        make.height.equalTo(0)
      }
    }
    countdown.setNeedsUpdateConstraints()
    self.layoutIfNeeded()
  }
}
