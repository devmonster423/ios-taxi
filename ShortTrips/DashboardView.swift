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

  private let numberLabel = UILabel()
  private let timerView = TimerView()
  private let reachabilityNotice = ReachabilityNotice()

  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.whiteColor()
    addSubview(timerView)
    
    let taxisCaptionLabel = UILabel()
    taxisCaptionLabel.backgroundColor = Color.Dashboard.lightBlue
    taxisCaptionLabel.font = Font.OpenSansBold.size(32)
    taxisCaptionLabel.text = NSLocalizedString("Taxis in lot", comment: "").uppercaseString
    taxisCaptionLabel.textAlignment = .Center
    taxisCaptionLabel.textColor = Color.Dashboard.darkBlue
    addSubview(taxisCaptionLabel)
    taxisCaptionLabel.snp_makeConstraints { make in
      make.height.equalTo(105)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(timerView.snp_top)
    }

    let circlesImage = UIImageView()
    circlesImage.image = Image.bgCircles.image()
    circlesImage.contentMode = .ScaleAspectFit
    addSubview(circlesImage)
    circlesImage.snp_makeConstraints { make in
      make.top.equalTo(self).offset(20)
      make.bottom.equalTo(taxisCaptionLabel.snp_top).offset(-20)
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
    
    timerView.snp_makeConstraints { make in
      make.height.equalTo(UiConstants.Dashboard.progressHeight)
      make.bottom.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }
    
    addSubview(reachabilityNotice)
    reachabilityNotice.snp_makeConstraints { make in
      make.height.equalTo(UiConstants.ReachabilityNotice.height)
      make.top.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }
  }
  
  func updateSpots(length: Int) {
    numberLabel.text = "\(length)"
  }
  
  func setReachabilityNoticeHidden(hidden: Bool) {
    reachabilityNotice.hidden = hidden
  }
  
  func startTimerView(updateInterval: NSTimeInterval, callback: TimerCallback) {
    timerView.start(updateInterval, callback: callback)
  }
  
  func stopTimerView() {
    timerView.stop()
  }
}
