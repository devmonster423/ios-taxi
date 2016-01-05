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
    addSubview(timerView)

    // background
    bgImageView.clipsToBounds = true
    bgImageView.contentMode = .ScaleAspectFill
    bgImageView.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self)
      make.left.equalTo(self)
      make.right.equalTo(self)
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
