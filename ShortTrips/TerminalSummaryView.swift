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
  let grayView = UIView()
  let hourPickerView = HourPickerView()
  var increaseButton: UIButton!
  let internationalTerminalView = TerminalView()
  let terminalView1 = TerminalView()
  let terminalView2 = TerminalView()
  let terminalView3 = TerminalView()
  var terminalViews: [TerminalView] = []
  let timerView = TimerView()
  let titleTerminalView = TerminalView()
  let totalTerminalView = TerminalView()
  let picker = UIPickerView()
  let pickerShower = UIButton(type: .System)
  let pickerHider = UIButton(type: .System)

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
    addSubview(pickerShower)
    addSubview(picker)
    addSubview(grayView)
    addSubview(pickerHider)
    
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
    
    pickerShower.setTitleColor(Color.Sfo.blue, forState: .Normal)
    pickerShower.titleLabel!.font = UiConstants.TerminalSummary.toggleFont
    pickerShower.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(totalTerminalView.snp_bottom).offset(10.0)
      make.height.equalTo(20)
      make.centerX.equalTo(self)
    }
    pickerShower.sizeToFit()
    
    decreaseButton = hourPickerView.decreaseButton
    increaseButton = hourPickerView.increaseButton
    hourPickerView.maxHour = 12
    hourPickerView.minHour = -2
    hourPickerView.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(self)
      make.top.equalTo(pickerShower.snp_bottom).offset(10.0)
      make.bottom.equalTo(timerView.snp_top)
      make.trailing.equalTo(self)
    }
    
    timerView.snp_makeConstraints { (make) -> Void in
      make.bottom.equalTo(self)
      make.height.equalTo(60)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }
    
    picker.alpha = 0.0
    picker.backgroundColor = UIColor.whiteColor()
    picker.hidden = true
    picker.snp_makeConstraints { (make) -> Void in
      make.bottom.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }
    
    pickerHider.alpha = 0.0
    pickerHider.hidden = true
    pickerHider.setTitleColor(Color.Sfo.blue, forState: .Normal)
    pickerHider.setTitle(NSLocalizedString(" Done ", comment: ""), forState: .Normal)
    pickerHider.backgroundColor = UIColor.whiteColor()
    pickerHider.titleLabel?.font = UiConstants.TerminalSummary.toggleFont
    pickerHider.snp_makeConstraints { (make) -> Void in
      make.bottom.equalTo(picker.snp_top)
      make.trailing.equalTo(self)
    }
    
    grayView.alpha = UiConstants.TerminalSummary.grayViewAlpha
    grayView.backgroundColor = UIColor.blackColor()
    grayView.hidden = true
    grayView.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self)
      make.bottom.equalTo(picker.snp_top)
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
    for i in 0..<summaries.count {
      terminalViews[i].configureForTerminalSummary(summaries[i])
    }
    totalTerminalView.configureTotals(TerminalSummary.getTotals(summaries))
  }
  
  func hidePicker() {
    UIView.animateWithDuration(UiConstants.TerminalSummary.fadeDuration, animations: {
      self.picker.alpha = 0.0
      self.pickerHider.alpha = 0.0
      self.grayView.alpha = 0.0
    }, completion: { finished in
      self.picker.hidden = true
      self.pickerHider.hidden = true
      self.grayView.hidden = true
    })
  }
  
  func showPicker() {
    picker.hidden = false
    pickerHider.hidden = false
    grayView.hidden = false
    UIView.animateWithDuration(UiConstants.TerminalSummary.fadeDuration, animations: { () -> Void in
      self.picker.alpha = 1.0
      self.pickerHider.alpha = 1.0
      self.grayView.alpha = UiConstants.TerminalSummary.grayViewAlpha
    })
  }
  
  func clearTerminalTable() {
    for terminalView in terminalViews {
      terminalView.clearTotals()
    }
    totalTerminalView.clearTotals()
  }
}
