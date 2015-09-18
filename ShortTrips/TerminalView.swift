//
//  TerminalView.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit
import SnapKit

class TerminalView: UIView {

  var activeTerminalId: TerminalId?
  
  private let delayedLabel = UILabel()
  private let onTimeLabel = UILabel()
  private let terminalImage = UIImageView()

  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(delayedLabel)
    addSubview(onTimeLabel)
    addSubview(terminalImage)
    
    terminalImage.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(self)
      make.top.equalTo(self)
      make.trailing.equalTo(self)
      make.height.equalTo(40)
    }

    let greenDot = UIImageView()
    greenDot.image = UIImage(named: "green_circle")
    addSubview(greenDot)
    greenDot.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(self).offset(10)
      make.top.equalTo(terminalImage.snp_bottom).offset(20)
      make.height.equalTo(10)
      make.width.equalTo(10)
    }

    let redDot = UIImageView()
    redDot.image = UIImage(named: "red_circle")
    addSubview(redDot)
    redDot.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(self).offset(10)
      make.top.equalTo(greenDot.snp_bottom).offset(20)
      make.height.equalTo(10)
      make.width.equalTo(10)
    }
    
    delayedLabel.textAlignment = .Center
    delayedLabel.textColor = UIColor.whiteColor()
    delayedLabel.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(redDot.snp_trailing).offset(5)
      make.centerY.equalTo(redDot)
      make.height.equalTo(21)
      make.width.equalTo(30)
    }
    
    onTimeLabel.textAlignment = .Center
    onTimeLabel.textColor = UIColor.whiteColor()
    onTimeLabel.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(greenDot.snp_trailing).offset(5)
      make.centerY.equalTo(greenDot)
      make.height.equalTo(21)
      make.width.equalTo(30)
    }

    let delayedTitleLabel = UILabel()
    delayedTitleLabel.text = NSLocalizedString("Delayed", comment: "").uppercaseString
    delayedTitleLabel.textAlignment = .Center
    delayedTitleLabel.textColor = UIColor.whiteColor()
    addSubview(delayedTitleLabel)
    delayedTitleLabel.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(delayedLabel.snp_trailing).offset(5)
      make.centerY.equalTo(redDot)
      make.height.equalTo(21)
      make.trailing.equalTo(self)
    }

    let onTimeTitleLabel = UILabel()
    onTimeTitleLabel.text = NSLocalizedString("On Time", comment: "")
    onTimeTitleLabel.textAlignment = .Center
    onTimeTitleLabel.textColor = UIColor.whiteColor()
    addSubview(onTimeTitleLabel)
    onTimeTitleLabel.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(onTimeLabel.snp_trailing).offset(5)
      make.centerY.equalTo(greenDot)
      make.height.equalTo(21)
      make.trailing.equalTo(self)
    }
  }

  func configureForTerminalSummary(summary: TerminalSummary) {

    activeTerminalId = summary.terminalId
    delayedLabel.text = "\(summary.delayedCount)"
    onTimeLabel.text = "\(summary.count)"

    switch summary.terminalId! {

    case .One:
      terminalImage.image = UIImage(named: "terminal_1")
    case .Two:
      terminalImage.image = UIImage(named: "terminal_2")
    case .Three:
      terminalImage.image = UIImage(named: "terminal_3")
    case .International:
      terminalImage.image = UIImage(named: "terminal_intl")
    }
  }
}
