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

  private let coneView = ConeView()
  private let lotView = LotView()
  private let timerView = TimerView()
  private let reachabilityNotice = ReachabilityNotice()

  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.white
    addSubview(timerView)
    
    addSubview(lotView)
    lotView.snp.makeConstraints { make in
      make.top.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(timerView.snp.top)
    }
    
    coneView.isHidden = true
    addSubview(coneView)
    coneView.snp.makeConstraints { make in
      make.top.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(timerView.snp.top)
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
  
  func updateForCone(_ cone: Cone) {
    coneView.updateForCone(cone)
  }
  
  func updateSpots(_ length: Int) {
    lotView.updateSpots(length)
  }
  
  func setReachabilityNoticeHidden(_ hidden: Bool) {
    reachabilityNotice.isHidden = hidden
  }
  
  func startTimerView(_ updateInterval: TimeInterval, callback: @escaping TimerCallback) {
    timerView.start(updateInterval, callback: callback)
  }
  
  func stopTimerView() {
    timerView.stop()
  }

  func forceUpdateTimerView() {
    timerView.updateAndRefresh()
  }
}
