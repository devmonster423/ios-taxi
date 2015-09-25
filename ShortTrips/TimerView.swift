//
//  TimerView.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/14/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit

class TimerView: UIView {

  private let progressView = UIProgressView()
  private let updateLabel = UILabel()

  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    progressView.progressTintColor = Color.Sfo.turquoise
    progressView.trackTintColor = Color.Sfo.lightBlue

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
  }

  func updateForTime(elapsedSeconds: Int) {
    if elapsedSeconds < 60 {
      updateLabel.text = NSLocalizedString("LAST UPDATED LESS THAN A MINUTE AGO", comment: "")
    }
    else if elapsedSeconds < 120 {
      updateLabel.text = NSLocalizedString("LAST UPDATED A MINUTE AGO", comment: "")
    }
    else {
      updateLabel.text = String(format: NSLocalizedString("LAST UPDATED %d MINUTES AGO", comment: ""), elapsedSeconds / 60)
    }
    progressView.progress = Float(elapsedSeconds) / Float(UiConstants.Timer.updatePeriod)
  }
}
