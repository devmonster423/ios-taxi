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

  let timerView = TimerView()

  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = UIColor.whiteColor()

    // add subviews
    addSubview(timerView)

    // background
    let bgView = UIView()
    bgView.backgroundColor = Color.Dashboard.lightBlue
    addSubview(bgView)
    bgView.snp_makeConstraints { make in
      make.top.equalTo(self.snp_centerY)
      make.left.equalTo(self)
      make.right.equalTo(self)
      make.bottom.equalTo(timerView.snp_top)
    }
    
    let blackCircle = UIImageView(image: Image.blackCircle.image())
    blackCircle.contentMode = .ScaleAspectFit
    addSubview(blackCircle)
    blackCircle.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self)
      make.height.equalTo(200)
      make.width.equalTo(200)
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
//    switch lotStatus {
//
//    case .Green:
//      bgImageView.image = nil
//
//    case .Yellow:
//      bgImageView.image = nil
//
//    case .Red:
//      bgImageView.image = nil
//    }
  }
}
