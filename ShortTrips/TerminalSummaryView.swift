//
//  TerminalSummaryView.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/14/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit
import SnapKit

class TerminalSummaryView: UIView {
  
  var decreaseButton: UIButton!
  let hourPickerView = HourPickerView()
  var increaseButton: UIButton!
  let terminalView1 = TerminalView()
  let terminalView2 = TerminalView()
  let terminalView3 = TerminalView()
  let terminalView4 = TerminalView()
  let timerView = TimerView()

  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    // general config
    backgroundColor = UIColor.whiteColor()

    // add subviews
    addSubview(hourPickerView)
    addSubview(terminalView1)
    addSubview(terminalView2)
    addSubview(terminalView3)
    addSubview(terminalView4)
    addSubview(timerView)

    // background image
    let bgImageView = UIImageView()
    bgImageView.image = UIImage(named: "terminal_bg.jpg")
    addSubview(bgImageView)
    sendSubviewToBack(bgImageView)
    bgImageView.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.height.equalTo(self).multipliedBy(0.67)
    }

    terminalView1.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self).offset(80)
      make.leading.equalTo(self).offset(25)
      make.height.equalTo(105)
      make.width.equalTo(self).multipliedBy(0.4)
    }

    terminalView2.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self).offset(80)
      make.trailing.equalTo(self).offset(-25)
      make.height.equalTo(105)
      make.width.equalTo(self).multipliedBy(0.4)
    }

    terminalView3.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(terminalView1.snp_bottom).offset(25)
      make.leading.equalTo(self).offset(25)
      make.height.equalTo(105)
      make.width.equalTo(self).multipliedBy(0.4)
    }

    terminalView4.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(terminalView2.snp_bottom).offset(25)
      make.trailing.equalTo(self).offset(-25)
      make.height.equalTo(105)
      make.width.equalTo(self).multipliedBy(0.4)
    }
    
    decreaseButton = hourPickerView.decreaseButton
    increaseButton = hourPickerView.increaseButton
    hourPickerView.maxHour = 10
    hourPickerView.minHour = -2
    hourPickerView.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(self)
      make.top.equalTo(bgImageView.snp_bottom).offset(10)
      make.bottom.equalTo(timerView.snp_top)
      make.width.equalTo(self)
    }
    
    timerView.snp_makeConstraints { (make) -> Void in
      make.bottom.equalTo(self)
      make.height.equalTo(60)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }
  }
  
  func getCurrentHour() -> Int {
    return hourPickerView.getCurrentHour()
  }
  
  func incrementHour(hourChange: Int) {
    hourPickerView.incrementHour(hourChange)
  }
  
  func reloadTerminalViews(summaries: [TerminalSummary]) {
    terminalView1.configureForTerminalSummary(summaries[0])
    terminalView2.configureForTerminalSummary(summaries[1])
    terminalView3.configureForTerminalSummary(summaries[2])
    terminalView4.configureForTerminalSummary(summaries[3])
  }
}
