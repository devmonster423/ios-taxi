//
//  TerminalView.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit
import SnapKit

class TerminalView: UIButton {

  fileprivate var activeTerminalId: TerminalId?
  
  fileprivate let delayedImageView = UIImageView()
  fileprivate let delayedLabel = UILabel()
  fileprivate let delayedTitleLabel = UILabel()
  fileprivate let indicatorImageView = UIImageView()
  fileprivate let onTimeImageView = UIImageView()
  fileprivate let onTimeLabel = UILabel()
  fileprivate let onTimeTitleLabel = UILabel()
  fileprivate let terminalTitleLabel = UILabel()

  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    // starts out hidden
    isHidden = true
    setBackgroundImage(Image.from(Color.Sfo.gray), for: .highlighted)

    addSubview(delayedImageView)
    addSubview(delayedLabel)
    addSubview(delayedTitleLabel)
    addSubview(indicatorImageView)
    addSubview(onTimeImageView)
    addSubview(onTimeLabel)
    addSubview(onTimeTitleLabel)
    addSubview(terminalTitleLabel)
    
    terminalTitleLabel.sizeToFit()
    terminalTitleLabel.textAlignment = .left
    terminalTitleLabel.textColor = Color.TerminalSummary.titleBlue
    terminalTitleLabel.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(self).offset(25)
      make.centerY.equalTo(self)
    }
    
    onTimeImageView.image = Image.blueCircle.image()
    onTimeImageView.contentMode = .scaleAspectFit
    onTimeImageView.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(onTimeTitleLabel)
      make.bottom.equalTo(self.snp_centerY).offset(-2)
      make.width.equalTo(10)
      make.height.equalTo(10)
    }
    
    onTimeLabel.sizeToFit()
    onTimeLabel.font = Font.OpenSansSemibold.size(18)
    onTimeLabel.textAlignment = .center
    onTimeLabel.textColor = Color.TerminalSummary.onTimeContent
    onTimeLabel.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(onTimeTitleLabel)
      make.centerY.equalTo(self)
    }
    
    onTimeTitleLabel.sizeToFit()
    onTimeTitleLabel.font = Font.OpenSansSemibold.size(13)
    onTimeTitleLabel.textAlignment = .center
    onTimeTitleLabel.text = NSLocalizedString("On Time", comment: "").uppercased()
    onTimeTitleLabel.textColor = Color.TerminalSummary.onTimeTitle
    onTimeTitleLabel.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(self)
      make.top.equalTo(self.snp_centerY).offset(2)
    }
    
    delayedImageView.image = Image.redCircle.image()
    delayedImageView.contentMode = .scaleAspectFit
    delayedImageView.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(delayedTitleLabel)
      make.centerY.equalTo(onTimeImageView)
      make.height.equalTo(onTimeImageView)
      make.width.equalTo(onTimeImageView)
    }
    
    delayedLabel.sizeToFit()
    delayedLabel.font = onTimeLabel.font
    delayedLabel.textAlignment = .center
    delayedLabel.textColor = Color.TerminalSummary.delayedContent
    delayedLabel.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(delayedTitleLabel)
      make.centerY.equalTo(onTimeLabel)
    }
    
    delayedTitleLabel.sizeToFit()
    delayedTitleLabel.font = onTimeTitleLabel.font
    delayedTitleLabel.text = NSLocalizedString("Delayed", comment: "").uppercased()
    delayedTitleLabel.textAlignment = .center
    delayedTitleLabel.textColor = Color.TerminalSummary.delayedTitle
    delayedTitleLabel.snp_makeConstraints { (make) -> Void in
      make.trailing.equalTo(indicatorImageView.snp_leading).offset(-18)
      make.centerY.equalTo(onTimeTitleLabel)
    }
    
    indicatorImageView.image = Image.indicatorArrow.image()
    indicatorImageView.contentMode = .scaleAspectFit
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
    
    isHidden = false
    isUserInteractionEnabled = false
    
    delayedImageView.isHidden = false
    delayedLabel.isHidden = true
    delayedTitleLabel.isHidden = false
    indicatorImageView.isHidden = true
    onTimeImageView.isHidden = false
    onTimeLabel.isHidden = true
    onTimeTitleLabel.isHidden = false
    terminalTitleLabel.font = Font.OpenSansBold.size(14)
    terminalTitleLabel.text = NSLocalizedString("Terminals", comment: "").uppercased()
  }
  
  func configureTotals(_ totals: (onTime: Int, delayed: Int)) {
    
    isHidden = false
    isUserInteractionEnabled = false
    
    delayedImageView.isHidden = true
    delayedLabel.text = "\(totals.delayed)"
    delayedTitleLabel.isHidden = true
    indicatorImageView.isHidden = true
    onTimeImageView.isHidden = true
    onTimeLabel.text = "\(totals.onTime)"
    onTimeTitleLabel.isHidden = true
    terminalTitleLabel.font = Font.OpenSansBold.size(14)
    terminalTitleLabel.text = NSLocalizedString("Totals", comment: "").uppercased()
  }

  func configureForTerminalSummary(_ summary: TerminalSummary?) {

    guard let summary = summary else { return }
    
    isHidden = false
    isUserInteractionEnabled = true
    
    activeTerminalId = summary.terminalId
    delayedImageView.isHidden = true
    delayedLabel.text = "\(summary.delayedCount)"
    delayedTitleLabel.isHidden = true
    indicatorImageView.isHidden = false
    onTimeImageView.isHidden = true
    onTimeLabel.text = "\(summary.onTimeCount)"
    onTimeTitleLabel.isHidden = true
    terminalTitleLabel.font = Font.OpenSansSemibold.size(14)

    switch summary.terminalId! {

    case .one:
      terminalTitleLabel.text = NSLocalizedString("Terminal", comment: "").uppercased() + " 1"
    case .two:
      terminalTitleLabel.text = NSLocalizedString("Terminal", comment: "").uppercased() + " 2"
    case .three:
      terminalTitleLabel.text = NSLocalizedString("Terminal", comment: "").uppercased() + " 3"
    case .international:
      terminalTitleLabel.text = NSLocalizedString("International", comment: "").uppercased()
    }
  }
  
  func clearTotals() {
    self.delayedLabel.text = ""
    self.onTimeLabel.text = ""
  }
  
  func setBackgroundDark(_ dark: Bool) {
    let color = dark ? Color.TerminalSummary.darkBackground : UIColor.white
    setBackgroundImage(Image.from(color), for: UIControlState())
  }
  
  func getActiveTerminalId() -> TerminalId? {
    return activeTerminalId
  }
}
