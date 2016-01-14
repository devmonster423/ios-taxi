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
      make.height.equalTo(self.snp_width).dividedBy(3)
      make.width.equalTo(self.snp_width).dividedBy(3)
    }
    
    let blackCircle = UIImageView(image: Image.blackCircle.image())
    blackCircle.contentMode = .ScaleAspectFit
    addSubview(blackCircle)
    blackCircle.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self)
      make.height.equalTo(whiteCircle).multipliedBy(0.93)
      make.width.equalTo(whiteCircle).multipliedBy(0.93)
    }
    
    fullnessRing.contentMode = .ScaleAspectFit
    addSubview(fullnessRing)
    fullnessRing.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self)
      make.height.equalTo(whiteCircle).multipliedBy(1.14)
      make.width.equalTo(whiteCircle).multipliedBy(1.14)
    }
    
    let holdingLotLabel = UILabel()
    holdingLotLabel.font = Font.OpenSansSemibold.size(28)
    holdingLotLabel.text = NSLocalizedString("Holding Lot", comment: "").uppercaseString
    holdingLotLabel.textAlignment = .Center
    addSubview(holdingLotLabel)
    holdingLotLabel.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(self)
      make.height.equalTo(40)
      make.width.equalTo(200)
      make.top.equalTo(self).offset(50)
    }
    
    percentLabel.font = Font.OpenSansSemibold.size(40)
    percentLabel.textAlignment = .Center
    percentLabel.textColor = UIColor.whiteColor()
    addSubview(percentLabel)
    percentLabel.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self)
      make.height.equalTo(150)
      make.width.equalTo(150)
    }
    
    let availableLabel = UILabel()
    availableLabel.font = Font.OpenSansBold.size(32)
    availableLabel.text = NSLocalizedString("Are Available", comment: "").uppercaseString
    availableLabel.textAlignment = .Center
    availableLabel.textColor = Color.Dashboard.darkBlue
    addSubview(availableLabel)
    availableLabel.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(30)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(bgView).offset(-5)
    }
    
    spotsLabel.font = Font.OpenSansSemibold.size(28)
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
  
  func updateSpots(length length: Int, capacity: Int) {
    let remaining = capacity - length
    let percent: Int = remaining * 100 / capacity
    
    percentLabel.text = "\(percent)%"
    spotsLabel.text = String(format: NSLocalizedString("%@ out of %@ spots", comment: ""), arguments: ["\(remaining)", "\(capacity)"]).uppercaseString
    
    if percent > 50 {
      fullnessRing.image = Image.greenRing.image()
      spotsLabel.textColor = Color.StatusColor.green
      
    } else if percent > 25 {
      fullnessRing.image = Image.yellowRing.image()
      spotsLabel.textColor = Color.StatusColor.yellow
      
    } else {
      fullnessRing.image = Image.redRing.image()
      spotsLabel.textColor = Color.StatusColor.red
    }
  }
}
