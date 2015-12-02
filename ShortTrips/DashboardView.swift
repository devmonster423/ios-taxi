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
  let flightStatusBtn = UIButton()
  let shortTripBtn = UIButton()
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
    addSubview(flightStatusBtn)
    addSubview(shortTripBtn)
    addSubview(timerView)

    // background
    bgImageView.clipsToBounds = true
    bgImageView.contentMode = .ScaleAspectFill
    bgImageView.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self)
      make.left.equalTo(self)
      make.right.equalTo(self)
      make.bottom.equalTo(flightStatusBtn.snp_top).offset(UiConstants.Dashboard.buttonBgOffset)
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

    // Flight Status Button
    flightStatusBtn.setTitle(NSLocalizedString("Flight Status", comment: "").uppercaseString, forState: .Normal)
    flightStatusBtn.setTitleColor(Color.Sfo.blue, forState: .Normal)
    flightStatusBtn.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
    flightStatusBtn.setBackgroundImage(Image.from(UIColor.whiteColor()), forState: .Normal)
    flightStatusBtn.setBackgroundImage(Image.from(Color.Sfo.blue), forState: .Highlighted)
    flightStatusBtn.titleLabel?.font = Font.MyriadProSemibold.size(UiConstants.Dashboard.buttonFontSize)
    flightStatusBtn.layer.borderColor = Color.Sfo.blue.CGColor
    flightStatusBtn.layer.borderWidth = UiConstants.Dashboard.statusBorderWidth
    flightStatusBtn.layer.cornerRadius = UiConstants.Dashboard.statusCornerRadius
    flightStatusBtn.clipsToBounds = true
    flightStatusBtn.snp_makeConstraints { (make) -> Void in
      make.width.equalTo(UiConstants.Dashboard.terminalStatusWidth)
      make.height.equalTo(UiConstants.Dashboard.buttonHeight)
      make.leading.equalTo(self).offset(UiConstants.Dashboard.buttonMargin)
      make.bottom.equalTo(timerView.snp_top).offset(UiConstants.Dashboard.buttonTimerOffset)
    }
    
    // Short Trip Button
    shortTripBtn.setTitle(NSLocalizedString("Short Trip", comment: "").uppercaseString, forState: .Normal)
    shortTripBtn.setTitleColor(Color.Sfo.blue, forState: .Normal)
    shortTripBtn.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
    shortTripBtn.setBackgroundImage(Image.from(UIColor.whiteColor()), forState: .Normal)
    shortTripBtn.setBackgroundImage(Image.from(Color.Sfo.blue), forState: .Highlighted)
    shortTripBtn.titleLabel?.font = Font.MyriadProSemibold.size(UiConstants.Dashboard.buttonFontSize)
    shortTripBtn.layer.borderColor = Color.Sfo.blue.CGColor
    shortTripBtn.layer.borderWidth = UiConstants.Dashboard.statusBorderWidth
    shortTripBtn.layer.cornerRadius = UiConstants.Dashboard.statusCornerRadius
    shortTripBtn.clipsToBounds = true
    shortTripBtn.snp_makeConstraints { (make) -> Void in
      make.width.equalTo(UiConstants.Dashboard.shortTripWidth)
      make.height.equalTo(UiConstants.Dashboard.buttonHeight)
      make.trailing.equalTo(self).offset(-1 * UiConstants.Dashboard.buttonMargin)
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
