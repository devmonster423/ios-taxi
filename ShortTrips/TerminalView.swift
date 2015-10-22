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

  private var activeTerminalId: TerminalId?
  
  private let delayedImageView = UIImageView()
  private let delayedLabel = UILabel()
  private let delayedTitleLabel = UILabel()
  private let indicatorImageView = UIImageView()
  private let onTimeImageView = UIImageView()
  private let onTimeLabel = UILabel()
  private let onTimeTitleLabel = UILabel()
  private let titleLabel = UILabel()

  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    // starts out hidden
    hidden = true

    addSubview(delayedImageView)
    addSubview(delayedLabel)
    addSubview(delayedTitleLabel)
    addSubview(indicatorImageView)
    addSubview(onTimeImageView)
    addSubview(onTimeLabel)
    addSubview(onTimeTitleLabel)
    addSubview(titleLabel)
    
    titleLabel.sizeToFit()
    titleLabel.textAlignment = .Left
    titleLabel.textColor = Color.TerminalSummary.titleBlue
    titleLabel.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(self).offset(25)
      make.centerY.equalTo(self)
    }
    
    onTimeImageView.image = Image.blueCircle.image()
    onTimeImageView.contentMode = .ScaleAspectFit
    onTimeImageView.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(onTimeTitleLabel)
      make.bottom.equalTo(self.snp_centerY).offset(-2)
      make.width.equalTo(10)
      make.height.equalTo(10)
    }
    
    onTimeLabel.sizeToFit()
    onTimeLabel.font = Font.MyriadProSemibold.size(18)
    onTimeLabel.textAlignment = .Center
    onTimeLabel.textColor = Color.TerminalSummary.onTimeContent
    onTimeLabel.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(onTimeTitleLabel)
      make.centerY.equalTo(self)
    }
    
    onTimeTitleLabel.sizeToFit()
    onTimeTitleLabel.font = Font.MyriadProSemibold.size(13)
    onTimeTitleLabel.textAlignment = .Center
    onTimeTitleLabel.text = NSLocalizedString("On Time", comment: "").uppercaseString
    onTimeTitleLabel.textColor = Color.TerminalSummary.onTimeTitle
    onTimeTitleLabel.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(self)
      make.top.equalTo(self.snp_centerY).offset(2)
    }
    
    delayedImageView.image = Image.redCircle.image()
    delayedImageView.contentMode = .ScaleAspectFit
    delayedImageView.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(delayedTitleLabel)
      make.centerY.equalTo(onTimeImageView)
      make.height.equalTo(onTimeImageView)
      make.width.equalTo(onTimeImageView)
    }
    
    delayedLabel.sizeToFit()
    delayedLabel.font = onTimeLabel.font
    delayedLabel.textAlignment = .Center
    delayedLabel.textColor = Color.TerminalSummary.delayedContent
    delayedLabel.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(delayedTitleLabel)
      make.centerY.equalTo(onTimeLabel)
    }
    
    delayedTitleLabel.sizeToFit()
    delayedTitleLabel.font = onTimeTitleLabel.font
    delayedTitleLabel.text = NSLocalizedString("Delayed", comment: "").uppercaseString
    delayedTitleLabel.textAlignment = .Center
    delayedTitleLabel.textColor = Color.TerminalSummary.delayedTitle
    delayedTitleLabel.snp_makeConstraints { (make) -> Void in
      make.trailing.equalTo(indicatorImageView.snp_leading).offset(-18)
      make.centerY.equalTo(onTimeTitleLabel)
    }
    
    indicatorImageView.image = Image.indicatorArrow.image()
    indicatorImageView.contentMode = .ScaleAspectFit
    indicatorImageView.snp_makeConstraints { (make) -> Void in
      make.centerY.equalTo(self)
      make.trailing.equalTo(self).offset(-18)
      make.width.equalTo(8)
      make.height.equalTo(12)
    }
    
    let separatorView = UIView()
    separatorView.backgroundColor = Color.TerminalSummary.separator
    addSubview(separatorView)
    separatorView.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(2)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self)
    }
  }
  
  func configureAsTitle() {
    
    hidden = false
    
    delayedImageView.hidden = false
    delayedLabel.hidden = true
    delayedTitleLabel.hidden = false
    indicatorImageView.hidden = true
    onTimeImageView.hidden = false
    onTimeLabel.hidden = true
    onTimeTitleLabel.hidden = false
    titleLabel.font = Font.MyriadProBold.size(14)
    titleLabel.text = NSLocalizedString("Terminals", comment: "").uppercaseString
  }
  
  func configureTotals(totals: (onTime: Int, delayed: Int)) {
    
    hidden = false
    
    delayedImageView.hidden = true
    delayedLabel.text = "\(totals.delayed)"
    delayedTitleLabel.hidden = true
    indicatorImageView.hidden = true
    onTimeImageView.hidden = true
    onTimeLabel.text = "\(totals.onTime)"
    onTimeTitleLabel.hidden = true
    titleLabel.font = Font.MyriadProBold.size(14)
    titleLabel.text = NSLocalizedString("Totals", comment: "").uppercaseString
  }

  func configureForTerminalSummary(summary: TerminalSummary) {

    hidden = false
    
    activeTerminalId = summary.terminalId
    delayedImageView.hidden = true
    delayedLabel.text = "\(summary.delayedCount)"
    delayedTitleLabel.hidden = true
    indicatorImageView.hidden = false
    onTimeImageView.hidden = true
    onTimeLabel.text = "\(summary.onTimeCount)"
    onTimeTitleLabel.hidden = true
    titleLabel.font = Font.MyriadProSemibold.size(14)

    switch summary.terminalId! {

    case .One:
      titleLabel.text = NSLocalizedString("Terminal", comment: "").uppercaseString + " 1"
    case .Two:
      titleLabel.text = NSLocalizedString("Terminal", comment: "").uppercaseString + " 2"
    case .Three:
      titleLabel.text = NSLocalizedString("Terminal", comment: "").uppercaseString + " 3"
    case .International:
      titleLabel.text = NSLocalizedString("International", comment: "").uppercaseString
    }
  }
  
  func clearTotals() {
    self.delayedLabel.text = ""
    self.onTimeLabel.text = ""
  }
  
  func setBackgroundDark(dark: Bool) {
    backgroundColor = dark ? Color.TerminalSummary.darkBackground : UIColor.whiteColor()
  }
  
  func getActiveTerminalId() -> TerminalId? {
    return activeTerminalId
  }
}
