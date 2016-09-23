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
  
  fileprivate var animatingFail = false
  
  fileprivate let countdown = CountdownView()
  fileprivate let promptLabel = UILabel()
  fileprivate let promptImageView = UIImageView()
  fileprivate let notificationView = NotificationView()
  fileprivate let reachabilityNotice = ReachabilityNotice()
  fileprivate var currentPrompt: StatePrompt?
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.white
    
    addSubview(countdown)
    addSubview(promptLabel)
    addSubview(promptImageView)
    
    countdown.snp.makeConstraints { make in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self).offset(-20)
      make.height.equalTo(0)
    }
    
    promptLabel.font = Font.OpenSansSemibold.size(30)
    promptLabel.textAlignment = .center
    promptLabel.numberOfLines = 0
    promptLabel.textColor = Color.Trip.title
    promptLabel.snp.makeConstraints { make in
      make.leading.equalTo(self).offset(25)
      make.trailing.equalTo(self).offset(-25)
      make.top.equalTo(self).offset(UiConstants.Trip.topMargin)
    }
    
    addSubview(notificationView)
    notificationView.isHidden = true
    
    promptImageView.contentMode = .scaleAspectFit
    promptImageView.snp.makeConstraints { make in
      make.leading.equalTo(self).offset(50)
      make.top.equalTo(promptLabel.snp.bottom)
      make.bottom.equalTo(countdown.snp.top)
      make.height.equalTo(self).dividedBy(Util.isIphone4Or5() ? 2.5 : 1.5).priority(250)
      make.trailing.equalTo(self).offset(-50)
    }
    
    bringSubview(toFront: notificationView)
    
    reachabilityNotice.isHidden = ReachabilityManager.sharedInstance.isReachable()
    addSubview(reachabilityNotice)
    reachabilityNotice.snp.makeConstraints { make in
      make.top.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.height.equalTo(UiConstants.ReachabilityNotice.height)
    }
  }
  
  func updatePrompt(_ prompt: StatePrompt) {
    if prompt != currentPrompt {
      promptLabel.text = prompt.visualString()
      promptImageView.image = prompt.image()
      Speaker.sharedInstance.speak(prompt.audioString())
      currentPrompt = prompt
    }
  }
  
  func notifySuccess(_ date: Date) {
    
    notificationView.snp.remakeConstraints { make in
      make.height.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self)
    }
    notificationView.setNeedsUpdateConstraints()
    layoutIfNeeded()
    
    notificationView.notifySuccess(date)
    notificationView.isHidden = false
  }
  
  func skipAnyPendingNotifications() {
    if animatingFail {
      self.notificationView.snp.remakeConstraints { make in
        make.height.equalTo(self).dividedBy(9)
        make.leading.equalTo(self)
        make.trailing.equalTo(self)
        make.bottom.equalTo(self)
      }
      
      self.promptImageView.snp.remakeConstraints { make in
        make.leading.equalTo(self).offset(50)
        make.top.equalTo(self.promptLabel.snp.bottom).offset(20)
        make.bottom.equalTo(self.notificationView.snp.top).offset(-20)
        make.height.equalTo(self).dividedBy(Util.isIphone4Or5() ? 2.5 : 1.5).priority(250)
        make.trailing.equalTo(self).offset(-50)
      }
      
      self.notificationView.setNeedsUpdateConstraints()
      self.promptImageView.setNeedsUpdateConstraints()
      self.layoutIfNeeded()
      
      animatingFail = false
    }
  }
  
  func notifyFail(_ validationStep: ValidationStep) {
    
    animatingFail = true
    
    notificationView.snp.remakeConstraints { make in
      make.height.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self)
    }
    
    promptImageView.snp.remakeConstraints { make in
      make.leading.equalTo(self).offset(50)
      make.top.equalTo(promptLabel.snp.bottom)
      make.bottom.equalTo(countdown.snp.top)
      make.height.equalTo(self).dividedBy(Util.isIphone4Or5() ? 2.5 : 1.5).priority(250)
      make.trailing.equalTo(self).offset(-50)
    }
    
    notificationView.setNeedsUpdateConstraints()
    promptImageView.setNeedsUpdateConstraints()
    layoutIfNeeded()
    self.notificationView.isHidden = false
    
    let duration: TimeInterval = 0.5
    let delay: TimeInterval = 5
    
    notificationView.notifyFail(validationStep, delay: delay, duration: duration)
    
    let delayTime = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: delayTime) {
      
      if self.animatingFail {
        self.notificationView.snp.remakeConstraints { make in
          make.height.equalTo(self).dividedBy(9)
          make.leading.equalTo(self)
          make.trailing.equalTo(self)
          make.bottom.equalTo(self)
        }
        
        self.promptImageView.snp.remakeConstraints { make in
          make.leading.equalTo(self).offset(50)
          make.top.equalTo(self.promptLabel.snp.bottom).offset(20)
          make.bottom.equalTo(self.notificationView.snp.top).offset(-20)
          make.height.equalTo(self).dividedBy(Util.isIphone4Or5() ? 2.5 : 1.5).priority(250)
          make.trailing.equalTo(self).offset(-50)
        }
        
        self.notificationView.setNeedsUpdateConstraints()
        self.promptImageView.setNeedsUpdateConstraints()
        UIView.animate(withDuration: duration,
          delay: 0,
          options: UIViewAnimationOptions(),
          animations: {
            self.layoutIfNeeded()
          },
          completion: { completed in
            self.animatingFail = false
          })
      }
    }
  }
  
  func hideNotification() {
    promptImageView.snp.remakeConstraints { make in
      make.leading.equalTo(self).offset(50)
      make.top.equalTo(promptLabel.snp.bottom)
      make.bottom.equalTo(countdown.snp.top)
      make.height.equalTo(self).dividedBy(Util.isIphone4Or5() ? 2.5 : 1.5).priority(250)
      make.trailing.equalTo(self).offset(-50)
    }
    promptImageView.setNeedsUpdateConstraints()
    self.layoutIfNeeded()
    notificationView.isHidden = true
  }
  
  func updateCountdown(_ elapsedTime: TimeInterval?) {
    countdown.updateCountdown(elapsedTime)
  }
  
  func getPromptText() -> String? {
    return promptLabel.text
  }
  
  func toggleCountdown(_ visible: Bool) {
    if visible {
      countdown.snp.remakeConstraints { make in
        make.leading.equalTo(self)
        make.trailing.equalTo(self)
        make.bottom.equalTo(self).offset(-20)
        make.height.equalTo(self).dividedBy(7)
      }
    } else {
      countdown.snp.remakeConstraints { make in
        make.leading.equalTo(self)
        make.trailing.equalTo(self)
        make.bottom.equalTo(self).offset(-20)
        make.height.equalTo(0)
      }
    }
    countdown.setNeedsUpdateConstraints()
    self.layoutIfNeeded()
  }
  
  func setReachabilityNoticeHidden(_ hidden: Bool) {
    reachabilityNotice.isHidden = hidden
  }
}
