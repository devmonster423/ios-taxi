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

  private let fullnessRing = UIImageView()
  private let percentLabel = UILabel()
  private let spotsLabel = UILabel()
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
    
    let whiteCircle = UIImageView(image: Image.whiteCircle.image())
    whiteCircle.contentMode = .ScaleAspectFit
    addSubview(whiteCircle)
    whiteCircle.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self)
      make.height.equalTo(215)
      make.width.equalTo(215)
    }
    
    let blackCircle = UIImageView(image: Image.blackCircle.image())
    blackCircle.contentMode = .ScaleAspectFit
    addSubview(blackCircle)
    blackCircle.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self)
      make.height.equalTo(200)
      make.width.equalTo(200)
    }
    
//    fullnessRing.image = Image.greenRing.image()
    fullnessRing.contentMode = .ScaleAspectFit
    addSubview(fullnessRing)
    fullnessRing.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self)
      make.height.equalTo(245)
      make.width.equalTo(245)
    }
    
    let holdingLotLabel = UILabel()
    holdingLotLabel.font = Font.MyriadProSemibold.size(28)
    holdingLotLabel.text = NSLocalizedString("Holding Lot", comment: "").uppercaseString
    holdingLotLabel.textAlignment = .Center
    addSubview(holdingLotLabel)
    holdingLotLabel.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(self)
      make.height.equalTo(40)
      make.width.equalTo(200)
      make.top.equalTo(self).offset(50)
    }
    
    percentLabel.font = Font.MyriadProSemibold.size(50)
    percentLabel.textAlignment = .Center
    percentLabel.textColor = UIColor.whiteColor()
    addSubview(percentLabel)
    percentLabel.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self)
      make.height.equalTo(150)
      make.width.equalTo(150)
    }
    
    let availableLabel = UILabel()
    availableLabel.font = Font.MyriadProBold.size(40)
    availableLabel.text = NSLocalizedString("Are Available", comment: "").uppercaseString
    availableLabel.textAlignment = .Center
    availableLabel.textColor = Color.Dashboard.darkBlue
    addSubview(availableLabel)
    availableLabel.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(50)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(bgView).offset(-10)
    }
    
    spotsLabel.font = Font.MyriadProSemibold.size(28)
    spotsLabel.textAlignment = .Center
    addSubview(spotsLabel)
    spotsLabel.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.top.equalTo(fullnessRing.snp_bottom)
      make.bottom.equalTo(availableLabel.snp_top)
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
      percentLabel.text = "75%"
      spotsLabel.text = String(format: NSLocalizedString("%@ out of %@ spots", comment: ""), arguments: ["300", "400"]).uppercaseString
      spotsLabel.textColor = Color.StatusColor.green
    case .Yellow:
      percentLabel.text = "25%"
      spotsLabel.text = String(format: NSLocalizedString("%@ out of %@ spots", comment: ""), arguments: ["100", "400"]).uppercaseString
      spotsLabel.textColor = Color.StatusColor.yellow
    case .Red:
      percentLabel.text = "0%"
      spotsLabel.text = String(format: NSLocalizedString("%@ out of %@ spots", comment: ""), arguments: ["0", "400"]).uppercaseString
      spotsLabel.textColor = Color.StatusColor.red
    }
  }
}
