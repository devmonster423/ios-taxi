//
//  UpdateTimer.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/20/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import UIKit

typealias Callback = () -> Void

class UpdateTimer: NSObject {
  
  static let sharedInstance = UpdateTimer()
  var timer: NSTimer?
  var elapsedSeconds: Int = 0
  var timerView: TimerView!
  var callback: Callback!
  
  override init() {}
  
  class func start(timerView: TimerView, callback: Callback) {
    sharedInstance.timerView = timerView
    sharedInstance.callback = callback
    resetProgress()
    sharedInstance.timer = NSTimer.scheduledTimerWithTimeInterval(UiConstants.updateInterval, target: sharedInstance.self, selector: "eachSecond", userInfo: nil, repeats: true)
  }
  
  private class func resetProgress() {
    sharedInstance.timerView.resetProgress()
    sharedInstance.elapsedSeconds = 0
  }

  func eachSecond() {
    timerView.updateForTime(elapsedSeconds)
    elapsedSeconds++
    if elapsedSeconds == UiConstants.updatePeriod {
      UpdateTimer.resetProgress()
      callback()
    }
  }

  class func stop() {
    sharedInstance.timer?.invalidate()
  }
}