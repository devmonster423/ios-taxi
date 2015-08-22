//
//  UpdateTimer.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/20/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import UIKit

class UpdateTimer: NSObject {
  
  static let sharedInstance = UpdateTimer()
  var timer: NSTimer!
  var elapsedSeconds: Int = 0
  var updateLabel: UILabel!
  var updateProgress: UIProgressView!
  var callback: (() -> Void)!
  
  override init() {}
  
  class func start(updateProgress: UIProgressView, updateLabel: UILabel, callback: () -> Void) {
    sharedInstance.updateProgress = updateProgress
    sharedInstance.updateLabel = updateLabel
    sharedInstance.callback = callback
    resetProgress()
    sharedInstance.timer = NSTimer.scheduledTimerWithTimeInterval(UiConstants.updateInterval, target: sharedInstance.self, selector: "eachSecond", userInfo: nil, repeats: true)
  }
  
  private class func resetProgress() {
    sharedInstance.updateLabel.text = NSLocalizedString("LAST UPDATED LESS THAN A MINUTE AGO", comment: "")
    sharedInstance.updateProgress.progress = 0.0
    sharedInstance.elapsedSeconds = 0
  }
  
  func eachSecond() {
    if elapsedSeconds < 60 {
      updateLabel.text = NSLocalizedString("LAST UPDATED LESS THAN A MINUTE AGO", comment: "")
    }
    else if elapsedSeconds < 120 {
      updateLabel.text = NSLocalizedString("LAST UPDATED A MINUTE AGO", comment: "")
    }
    else {
      updateLabel.text = String(format: NSLocalizedString("LAST UPDATED %d MINUTES AGO", comment: ""), elapsedSeconds / 60)
    }
    updateProgress.progress = Float(elapsedSeconds) / Float(UiConstants.updatePeriod)
    elapsedSeconds++
    if elapsedSeconds == UiConstants.updatePeriod {
      UpdateTimer.resetProgress()
      callback()
    }
  }

  class func stop() {
    sharedInstance.timer.invalidate()
  }
}