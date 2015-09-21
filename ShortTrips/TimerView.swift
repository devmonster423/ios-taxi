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

    // add subviews
    addSubview(progressView)
    addSubview(updateLabel)

    progressView.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(self).offset(UiConstants.dashboardMargin)
      make.trailing.equalTo(self).offset(-UiConstants.dashboardMargin)
      make.bottom.equalTo(self).offset(-UiConstants.dashboardMargin)
      make.height.equalTo(2)
    }

    updateLabel.font = Font.MyriadProSemibold.size(18)
    updateLabel.textAlignment = .Center
    updateLabel.textColor = Color.Sfo.blue
    updateLabel.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(22)
      make.leading.equalTo(self).offset(UiConstants.dashboardMargin)
      make.trailing.equalTo(self).offset(-UiConstants.dashboardMargin)
      make.top.equalTo(self)
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
    progressView.progress = Float(elapsedSeconds) / Float(UiConstants.updatePeriod)
  }
}
