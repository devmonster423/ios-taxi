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
    
    let holdingLotLabel = UILabel()
    holdingLotLabel.font = Font.OpenSansSemibold.size(30)
    holdingLotLabel.text = NSLocalizedString("Holding Lot", comment: "").uppercaseString
    holdingLotLabel.textAlignment = .Center
    addSubview(holdingLotLabel)
    holdingLotLabel.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(self)
      make.height.equalTo(40)
      make.width.equalTo(250)
      make.top.equalTo(self).offset(50)
    }
    
    let taxi = UIImageView(image: Image.taxi.image())
    taxi.contentMode = .ScaleAspectFit
    addSubview(taxi)
    taxi.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(self)
      make.centerY.equalTo(self).offset(-30)
      make.height.equalTo(self.snp_width).dividedBy(2.5)
      make.width.equalTo(self.snp_width).dividedBy(2.5)
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
      //make.top.equalTo(taxi.snp_bottom)
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
    spotsLabel.text = String(format: NSLocalizedString("%@ out of %@ spots", comment: ""), arguments: ["\(remaining)", "\(capacity)"]).uppercaseString
    if percent > 50 {
      spotsLabel.textColor = Color.StatusColor.green
    } else if percent > 25 {
      spotsLabel.textColor = Color.StatusColor.yellow
    } else {
      spotsLabel.textColor = Color.StatusColor.red
    }
  }
}
