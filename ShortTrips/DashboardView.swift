//
//  DashboardView.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/14/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit
import SnapKit

class DashboardView: UIView {

  private let bgImageView = UIImageView()
  private let bgOverlayView = UIImageView()
  private let fullnessTitleLabel = UILabel()
  internal let fullnessLabel = UILabel()
  let terminalStatusBtn = UIButton()
  let timerView = TimerView()

  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = UIColor.whiteColor()

    // add subviews
    addSubview(bgImageView)
    addSubview(fullnessLabel)
    addSubview(fullnessTitleLabel)
    addSubview(bgOverlayView)
    addSubview(terminalStatusBtn)
    addSubview(timerView)

    // background
    bgImageView.clipsToBounds = true
    bgImageView.contentMode = .ScaleAspectFill
    bgImageView.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self)
      make.left.equalTo(self)
      make.right.equalTo(self)
      make.bottom.equalTo(terminalStatusBtn.snp_top).offset(UiConstants.Dashboard.buttonBgOffset)
    }

    // black alpha view on top of background
    bgOverlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: UiConstants.Dashboard.overlayAlpha)
    addSubview(bgOverlayView)
    bgOverlayView.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(self)
      make.right.equalTo(self)
      make.top.equalTo(bgImageView.snp_bottom)
      make.bottom.equalTo(timerView.snp_top)
    }

    // "FULL"
    fullnessLabel.font = Font.MyriadProBold.size(UiConstants.Dashboard.fullnessFontSize)
    fullnessLabel.numberOfLines = 0
    fullnessLabel.textColor = UIColor.whiteColor()
    fullnessLabel.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(bgImageView)
      make.centerY.equalTo(bgImageView)
    }
    
    // "Our holding lot is"
    fullnessTitleLabel.text = NSLocalizedString("Our holding lot is", comment: "")
    fullnessTitleLabel.font = Font.MyriadPro.size(UiConstants.Dashboard.fullnessLabelFontSize)
    fullnessTitleLabel.numberOfLines = 0
    fullnessTitleLabel.textColor = UIColor.whiteColor()
    fullnessTitleLabel.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(bgImageView)
      make.bottom.equalTo(fullnessLabel.snp_top)
    }
    
    // Progress View and "Last updated 2 minutes ago"
    timerView.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(UiConstants.Dashboard.progressHeight)
      make.bottom.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }

    // Terminal Status Button
    terminalStatusBtn.setTitle(NSLocalizedString("Terminal Status", comment: "").uppercaseString, forState: .Normal)
    terminalStatusBtn.setTitleColor(Color.Sfo.blue, forState: .Normal)
    terminalStatusBtn.titleLabel?.font = Font.MyriadProSemibold.size(UiConstants.Dashboard.terminalStatusFontSize)
    terminalStatusBtn.layer.borderColor = Color.Sfo.blue.CGColor
    terminalStatusBtn.layer.borderWidth = UiConstants.Dashboard.statusBorderWidth
    terminalStatusBtn.layer.cornerRadius = UiConstants.Dashboard.statusCornerRadius
    terminalStatusBtn.snp_makeConstraints { (make) -> Void in
      make.width.equalTo(UiConstants.Dashboard.terminalStatusWidth)
      make.height.equalTo(UiConstants.Dashboard.terminalStatusHeight)
      make.centerX.equalTo(self)
      make.bottom.equalTo(timerView.snp_top).offset(UiConstants.Dashboard.buttonTimerOffset)
    }
  }

  func updateStatusUI(lotStatus: LotStatusEnum) {
    switch lotStatus {

    case .Green:
      bgImageView.image = UIImage(named: "greenDashBg.png")
      fullnessLabel.text = NSLocalizedString("not full", comment: "").uppercaseString

    case .Yellow:
      bgImageView.image = UIImage(named: "yellowDashBg.png")
      fullnessLabel.text = NSLocalizedString("almost full", comment: "").uppercaseString

    case .Red:
      bgImageView.image = UIImage(named: "redDashBg.png")
      fullnessLabel.text = NSLocalizedString("full", comment: "").uppercaseString
    }
  }
}
