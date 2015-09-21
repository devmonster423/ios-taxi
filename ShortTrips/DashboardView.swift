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
  private let comeToSfoLabel = UILabel()
  private let directionLabel = UILabel()
  let explanationLabel = UILabel()
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
    addSubview(explanationLabel)
    addSubview(comeToSfoLabel)
    addSubview(directionLabel)
    addSubview(terminalStatusBtn)
    addSubview(timerView)

    // background
    bgImageView.clipsToBounds = true
    bgImageView.contentMode = .ScaleAspectFill
    bgImageView.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self)
      make.left.equalTo(self)
      make.right.equalTo(self)
      make.bottom.equalTo(terminalStatusBtn.snp_top).offset(-10)
    }

    // black alpha view on top of background
    let backgroundOverlay = UIView()
    backgroundOverlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    addSubview(backgroundOverlay)
    backgroundOverlay.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(bgImageView)
    }

    // "the lot is full"
    explanationLabel.font = Font.MyriadProBold.size(40)
    explanationLabel.numberOfLines = 0
    explanationLabel.textColor = UIColor.whiteColor()
    explanationLabel.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(self).offset(UiConstants.dashboardMargin)
      make.trailing.equalTo(self).offset(-UiConstants.dashboardMargin)
      make.height.equalTo(120)
      make.bottom.equalTo(bgImageView)
    }

    // white separator line
    let separator = UIView()
    separator.backgroundColor = UIColor.whiteColor()
    addSubview(separator)
    separator.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(1)
      make.width.equalTo(200)
      make.leading.equalTo(self).offset(UiConstants.dashboardMargin)
      make.bottom.equalTo(explanationLabel.snp_top)
    }

    // "Come to SFO"
    comeToSfoLabel.font = Font.MyriadPro.size(40)
    comeToSfoLabel.textColor = UIColor.whiteColor()
    comeToSfoLabel.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(80)
      make.width.equalTo(270)
      make.leading.equalTo(UiConstants.dashboardMargin)
      make.bottom.equalTo(separator.snp_top)
    }

    // "YES/NO/MAYBE"
    directionLabel.font = Font.MyriadPro.size(60)
    directionLabel.textColor = UIColor.whiteColor()
    directionLabel.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(self).offset(UiConstants.dashboardMargin)
      make.trailing.equalTo(self).offset(-UiConstants.dashboardMargin)
      make.height.equalTo(80)
      make.bottom.equalTo(comeToSfoLabel.snp_top)
    }

    // Progress View and "Last updated 2 minutes ago"
    timerView.snp_makeConstraints { (make) -> Void in
      make.bottom.equalTo(self)
      make.height.equalTo(60)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }

    // Terminal Status Button
    terminalStatusBtn.setTitle(NSLocalizedString("Terminal Status", comment: "").uppercaseString, forState: .Normal)
    terminalStatusBtn.setTitleColor(Color.Sfo.blue, forState: .Normal)
    terminalStatusBtn.titleLabel?.font = Font.MyriadProSemibold.size(15)
    terminalStatusBtn.layer.borderColor = Color.Sfo.blue.CGColor
    terminalStatusBtn.layer.borderWidth = UiConstants.statusBorderWidth
    terminalStatusBtn.layer.cornerRadius = UiConstants.statusCornerRadius
    terminalStatusBtn.snp_makeConstraints { (make) -> Void in
      make.width.equalTo(200)
      make.height.equalTo(80)
      make.centerX.equalTo(self)
      make.bottom.equalTo(timerView.snp_top).offset(-10)
    }
  }

  func updateStatusUI(lotStatus: LotStatusEnum) {
    switch lotStatus {

    case .Yes:
      bgImageView.image = UIImage(named: "green_bg.jpg")
      comeToSfoLabel.text = NSLocalizedString("Go To SFO", comment: "")
      directionLabel.text = NSLocalizedString(lotStatus.rawValue, comment: "")
      explanationLabel.text = NSLocalizedString("Lot capacity is not full", comment: "")

    case .Maybe:
      bgImageView.image = UIImage(named: "yellow_bg.jpg")
      comeToSfoLabel.text = NSLocalizedString("Go To SFO", comment: "")
      directionLabel.text = NSLocalizedString(lotStatus.rawValue, comment: "")
      explanationLabel.text = NSLocalizedString("Lot capacity is almost full", comment: "")

    case .No:
      bgImageView.image = UIImage(named: "red_bg.jpg")
      comeToSfoLabel.text = NSLocalizedString("Don't Go To SFO", comment: "")
      directionLabel.text = NSLocalizedString(lotStatus.rawValue, comment: "")
      explanationLabel.text = NSLocalizedString("Lot capacity is full", comment: "")
    }
  }
}
