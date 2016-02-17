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

  private let spotsLabel = UILabel()
  private let numberLabel = UILabel()
  private let circlesImage = UIImageView()
  let timerView = TimerView()

  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.whiteColor()
    addSubview(timerView)
    
    let bgView = UIView()
    bgView.backgroundColor = Color.Dashboard.lightBlue
    addSubview(bgView)
    bgView.snp_makeConstraints { make in
      make.height.equalTo(105)
      make.left.equalTo(self)
      make.right.equalTo(self)
      make.bottom.equalTo(timerView.snp_top)
    }
    
    circlesImage.image = Image.bgCircles.image()
    circlesImage.contentMode = .ScaleAspectFit
    addSubview(circlesImage)
    circlesImage.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self)
      make.bottom.equalTo(bgView.snp_top)
      make.leading.equalTo(self).offset(50)
      make.trailing.equalTo(self).offset(-50)
    }

    numberLabel.font = Font.OpenSansBold.size(180)
    numberLabel.textAlignment = .Center
    numberLabel.textColor = Color.Dashboard.darkBlue
    addSubview(numberLabel)
    numberLabel.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(circlesImage.snp_centerX)
      make.centerY.equalTo(circlesImage.snp_centerY)
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
      make.bottom.equalTo(bgView).offset(-15)
    }
    
    spotsLabel.font = Font.OpenSansSemibold.size(28)
    spotsLabel.textAlignment = .Center
    addSubview(spotsLabel)
    spotsLabel.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(availableLabel.snp_top).offset(-10)
    }
    
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
    numberLabel.text = "\(remaining)"
    spotsLabel.text = String(format: NSLocalizedString("out of %@ spots", comment: ""), arguments: ["\(capacity)"]).uppercaseString
    if percent > 50 {
      spotsLabel.textColor = Color.StatusColor.green
    } else if percent > 25 {
      spotsLabel.textColor = Color.StatusColor.yellow
    } else {
      spotsLabel.textColor = Color.StatusColor.red
    }
  }
}
