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

  fileprivate let numberLabel = UILabel()
  fileprivate let timerView = TimerView()
  fileprivate let reachabilityNotice = ReachabilityNotice()

  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.white
    addSubview(timerView)
    
    let taxisCaptionLabel = UILabel()
    taxisCaptionLabel.backgroundColor = Color.Dashboard.lightBlue
    taxisCaptionLabel.font = Font.OpenSansBold.size(32)
    taxisCaptionLabel.text = NSLocalizedString("Taxis in lot", comment: "").uppercased()
    taxisCaptionLabel.textAlignment = .center
    taxisCaptionLabel.textColor = Color.Dashboard.darkBlue
    addSubview(taxisCaptionLabel)
    taxisCaptionLabel.snp.makeConstraints { make in
      make.height.equalTo(105)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(timerView.snp.top)
    }

    let circlesImage = UIImageView()
    circlesImage.image = Image.bgCircles.image()
    circlesImage.contentMode = .scaleAspectFit
    addSubview(circlesImage)
    circlesImage.snp.makeConstraints { make in
      make.top.equalTo(self).offset(20)
      make.bottom.equalTo(taxisCaptionLabel.snp.top).offset(-20)
      make.leading.equalTo(self).offset(50)
      make.trailing.equalTo(self).offset(-50)
    }

    numberLabel.font = Font.OpenSansBold.size(180)
    numberLabel.textAlignment = .center
    numberLabel.textColor = Color.Dashboard.darkBlue
    addSubview(numberLabel)
    numberLabel.snp.makeConstraints { (make) -> Void in
      make.centerX.equalTo(circlesImage.snp.centerX)
      make.centerY.equalTo(circlesImage.snp.centerY)
    }
    
    timerView.snp.makeConstraints { make in
      make.height.equalTo(UiConstants.Dashboard.progressHeight)
      make.bottom.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }
    
    addSubview(reachabilityNotice)
    reachabilityNotice.snp.makeConstraints { make in
      make.height.equalTo(UiConstants.ReachabilityNotice.height)
      make.top.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }
  }
  
  func updateSpots(_ length: Int) {
    numberLabel.text = "\(length)"
  }
  
  func setReachabilityNoticeHidden(_ hidden: Bool) {
    reachabilityNotice.isHidden = hidden
  }
  
  func startTimerView(_ updateInterval: TimeInterval, callback: TimerCallback) {
    timerView.start(updateInterval, callback: callback)
  }
  
  func stopTimerView() {
    timerView.stop()
  }
}
