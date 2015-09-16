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

  let hourPickerView = HourPickerView()
  let timerView = TimerView()
  
  private let terminalView1 = TerminalView()
  private let terminalView2 = TerminalView()
  private let terminalView3 = TerminalView()
  private let terminalView4 = TerminalView()

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
      make.width.equalTo(130)
    }

    terminalView2.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self).offset(80)
      make.trailing.equalTo(self).offset(-25)
      make.height.equalTo(105)
      make.width.equalTo(130)
    }

    terminalView3.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(terminalView1.snp_bottom).offset(25)
      make.leading.equalTo(self).offset(25)
      make.height.equalTo(105)
      make.width.equalTo(130)
    }

    terminalView4.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(terminalView2.snp_bottom).offset(25)
      make.trailing.equalTo(self).offset(-25)
      make.height.equalTo(105)
      make.width.equalTo(130)
    }
    
    hourPickerView.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(self)
      make.top.equalTo(bgImageView.snp_bottom).offset(10)
      make.height.equalTo(100)
      make.width.equalTo(300)
    }
    
    timerView.snp_makeConstraints { (make) -> Void in
      make.bottom.equalTo(self)
      make.height.equalTo(60)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }
  }
}
