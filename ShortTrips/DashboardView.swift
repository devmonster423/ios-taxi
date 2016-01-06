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

  let bgImageView = UIImageView()
  private let bgOverlayView = UIImageView()
  let timerView = TimerView()

  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = UIColor.whiteColor()

    // add subviews
    addSubview(bgImageView)
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
    
    // Progress View and "Last updated 2 minutes ago"
    timerView.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(UiConstants.Dashboard.progressHeight)
      make.bottom.equalTo(self).offset(-tabBarHeight)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }
  }

  func updateStatusUI(lotStatus: LotStatusEnum) {
    switch lotStatus {

    case .Green:
      bgImageView.image = Image.available.image()

    case .Yellow:
      bgImageView.image = Image.almostFull.image()

    case .Red:
      bgImageView.image = Image.full.image()
    }
  }
}
