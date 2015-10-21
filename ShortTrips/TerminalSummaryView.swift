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
  let internationalTerminalView = TerminalView()
  let timerView = TimerView()
  let titleTerminalView = TerminalView()
  let totalTerminalView = TerminalView()
  var terminalViews: [TerminalView] = []

  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.whiteColor()
    terminalViews.append(terminalView1)
    terminalViews.append(terminalView2)
    terminalViews.append(terminalView3)
    terminalViews.append(internationalTerminalView)
    for terminalView in terminalViews {
      addSubview(terminalView)
    }
    addSubview(hourPickerView)
    addSubview(timerView)
    addSubview(titleTerminalView)
    addSubview(totalTerminalView)
    
    titleTerminalView.configureAsTitle()
    titleTerminalView.setBackgroundDark(true)
    titleTerminalView.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.top.equalTo(self)
      make.height.equalTo(self).multipliedBy(0.104)
    }
    
    internationalTerminalView.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(titleTerminalView.snp_bottom)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.height.equalTo(self).multipliedBy(0.096)
    }

    terminalView1.setBackgroundDark(true)
    terminalView1.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(internationalTerminalView.snp_bottom)
      make.leading.equalTo(self)
      make.height.equalTo(internationalTerminalView)
      make.trailing.equalTo(self)
    }

    terminalView2.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(terminalView1.snp_bottom)
      make.trailing.equalTo(self)
      make.height.equalTo(terminalView1)
      make.leading.equalTo(self)
    }

    terminalView3.setBackgroundDark(true)
    terminalView3.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(terminalView2.snp_bottom)
      make.leading.equalTo(self)
      make.height.equalTo(terminalView2)
      make.trailing.equalTo(self)
    }
    
    totalTerminalView.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(terminalView3.snp_bottom)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.height.equalTo(terminalView3)
    }
    
    decreaseButton = hourPickerView.decreaseButton
    increaseButton = hourPickerView.increaseButton
    hourPickerView.maxHour = 12
    hourPickerView.minHour = -2
    hourPickerView.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(self)
      make.top.equalTo(totalTerminalView.snp_bottom)
      make.bottom.equalTo(timerView.snp_top)
      make.trailing.equalTo(self)
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
    for i in 0...3 {
      terminalViews[i].configureForTerminalSummary(summaries[i])
    }
    totalTerminalView.configureTotals(TerminalSummary.getTotals(summaries))
  }
  
  func clearTerminalTable() {
    for terminalView in terminalViews {
      terminalView.clearTotals()
    }
    totalTerminalView.clearTotals()
  }
}
