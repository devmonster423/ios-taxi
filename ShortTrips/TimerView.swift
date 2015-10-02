//
//  TimerView.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/14/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit

typealias TimerCallback = () -> Void

class TimerView: UIView {

  // behavior properties
  private var callback: TimerCallback?
  private var elapsedSeconds: NSTimeInterval = 0
  private var timer: NSTimer?
  private var updateInterval: NSTimeInterval!
  
  // subviews
  private let progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.Bar)
  private let updateLabel = UILabel()

  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    progressView.progressTintColor = Color.Sfo.turquoise
    progressView.trackTintColor = Color.Sfo.lightBlue

    // add subviews
    addSubview(progressView)
    addSubview(updateLabel)

    progressView.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self)
      make.height.equalTo(UiConstants.Timer.progressHeight)
    }

    updateLabel.font = Font.MyriadProSemibold.size(UiConstants.Timer.updateHeight)
    updateLabel.textAlignment = .Center
    updateLabel.textColor = Color.Sfo.gray
    updateLabel.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(progressView.snp_top).offset(UiConstants.Timer.bottomOffset)
    }
  }

  func resetProgress() {
    updateLabel.text = NSLocalizedString("LAST UPDATED LESS THAN A MINUTE AGO", comment: "")
    progressView.progress = 0.0
    elapsedSeconds = 0
  }

  func updateForTime(elapsedSeconds: NSTimeInterval) {
    if elapsedSeconds < 60 {
      updateLabel.text = NSLocalizedString("LAST UPDATED LESS THAN A MINUTE AGO", comment: "")
    }
    else if elapsedSeconds < 120 {
      updateLabel.text = NSLocalizedString("LAST UPDATED A MINUTE AGO", comment: "")
    }
    else {
      updateLabel.text = String(format: NSLocalizedString("LAST UPDATED %d MINUTES AGO", comment: ""), elapsedSeconds / 60)
    }
    progressView.progress = Float(elapsedSeconds) / Float(updateInterval)
  }
  
  // behavior
  
  func start(callback: TimerCallback?, updateInterval: NSTimeInterval) {
    self.callback = callback
    self.updateInterval = updateInterval
    timer?.invalidate()
    timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "eachSecond", userInfo: nil, repeats: true)
  }
  
  func eachSecond() {
    elapsedSeconds++
    updateForTime(elapsedSeconds)
    if elapsedSeconds >= updateInterval {
      resetProgress()
      callback?()
    }
  }
  
  func stop() {
    timer?.invalidate()
  }
}
