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
  private var callback: TimerCallback!
  private var lastUpdateDate: NSDate?
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

    updateLabel.font = Font.OpenSansSemibold.size(UiConstants.Timer.updateHeight)
    updateLabel.textAlignment = .Center
    updateLabel.textColor = Color.Sfo.gray
    updateLabel.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(progressView.snp_top).offset(UiConstants.Timer.bottomOffset)
    }
  }

  func updateForTime(elapsedSeconds: NSTimeInterval) {
    if elapsedSeconds < 60 {
      updateLabel.text = NSLocalizedString("LAST UPDATED LESS THAN A MINUTE AGO", comment: "")
    }
    else if elapsedSeconds < 120 {
      updateLabel.text = NSLocalizedString("LAST UPDATED A MINUTE AGO", comment: "")
    }
    else {
      updateLabel.text = String(format: NSLocalizedString("LAST UPDATED %d MINUTES AGO", comment: ""), Int(elapsedSeconds / 60))
    }
    progressView.progress = Float(elapsedSeconds) / Float(updateInterval)
  }
  
  func start(updateInterval: NSTimeInterval, callback: TimerCallback) {
    self.callback = callback
    self.updateInterval = updateInterval
    timer?.invalidate()
    weak var weakSelf = self
    timer = NSTimer.scheduledTimerWithTimeInterval(UiConstants.Timer.updateInterval,
      target: weakSelf!,
      selector: #selector(eachSecond),
      userInfo: nil,
      repeats: true)
    eachSecond()
  }
  
  func resetProgress() {
    updateLabel.text = NSLocalizedString("LAST UPDATED LESS THAN A MINUTE AGO", comment: "")
    progressView.progress = 0.0
    lastUpdateDate = NSDate()
  }
  
  func updateAndRefresh() {
    if ReachabilityManager.sharedInstance.isReachable() {
      resetProgress()
      callback()
    }
  }
  
  func eachSecond() {
    if let lastUpdateDate = lastUpdateDate {
      let elapsedSeconds = -lastUpdateDate.timeIntervalSinceNow
      updateForTime(elapsedSeconds)
      if elapsedSeconds >= updateInterval {
        updateAndRefresh()
      }
    } else {
      updateAndRefresh()
    }
  }
  
  func stop() {
    timer?.invalidate()
  }
}
