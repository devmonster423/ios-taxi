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
  
  fileprivate let grayView = UIView()
  fileprivate let hourPickerView = HourPickerView()
  fileprivate let internationalTerminalView = TerminalView()
  fileprivate let terminalView1 = TerminalView()
  fileprivate let terminalView2 = TerminalView()
  fileprivate let terminalView3 = TerminalView()
  fileprivate var terminalViews: [TerminalView] = []
  fileprivate let timerView = TimerView()
  fileprivate let titleTerminalView = TerminalView()
  fileprivate let totalTerminalView = TerminalView()
  fileprivate let picker = UIPickerView()
  fileprivate let pickerShower = UIButton()
  fileprivate let pickerTitle = UILabel()
  fileprivate let pickerDismissToolbar = UIToolbar()
  fileprivate let reachabilityNotice = ReachabilityNotice()

  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.white
    
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
    addSubview(pickerDismissToolbar)
    
    let divider = UIView()
    divider.backgroundColor = Color.Sfo.blue
    addSubview(divider)
    divider.snp.makeConstraints { (make) -> Void in
      make.height.equalTo(1)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.top.equalTo(self)
    }
    
    titleTerminalView.configureAsTitle()
    titleTerminalView.setBackgroundDark(true)
    titleTerminalView.snp.makeConstraints { (make) -> Void in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.top.equalTo(pickerShower.snp.bottom)
      make.height.equalTo(self).multipliedBy(0.104)
    }
    
    internationalTerminalView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(titleTerminalView.snp.bottom)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.height.equalTo(self).multipliedBy(0.096)
    }

    terminalView1.setBackgroundDark(true)
    terminalView1.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(internationalTerminalView.snp.bottom)
      make.leading.equalTo(self)
      make.height.equalTo(internationalTerminalView)
      make.trailing.equalTo(self)
    }

    terminalView2.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(terminalView1.snp.bottom)
      make.trailing.equalTo(self)
      make.height.equalTo(terminalView1)
      make.leading.equalTo(self)
    }

    terminalView3.setBackgroundDark(true)
    terminalView3.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(terminalView2.snp.bottom)
      make.leading.equalTo(self)
      make.height.equalTo(terminalView2)
      make.trailing.equalTo(self)
    }
    
    totalTerminalView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(terminalView3.snp.bottom)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.height.equalTo(terminalView3)
    }
    
    pickerShower.setBackgroundImage(Image.from(Color.NavBar.subtitleBlue), for: UIControlState())
    pickerShower.setBackgroundImage(Image.from(Color.NavBar.subtitleBluePressed), for: .highlighted)
    pickerShower.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(divider.snp.bottom)
      make.height.equalTo(44)
      make.centerX.equalTo(self)
      make.width.equalTo(self)
    }
    
    pickerTitle.font = UiConstants.TerminalSummary.toggleFont
    pickerTitle.text = FlightType.Arrivals.asLocalizedString()
    pickerTitle.textAlignment = .center
    pickerTitle.textColor = UIColor.white
    pickerShower.addSubview(pickerTitle)
    pickerTitle.snp.makeConstraints { (make) -> Void in
      make.width.equalTo(150)
      make.height.equalTo(30)
      make.center.equalTo(pickerShower)
    }
    
    let downArrowImageView = UIImageView()
    downArrowImageView.image = Image.downArrow.image()
    downArrowImageView.contentMode = .scaleAspectFit
    pickerShower.addSubview(downArrowImageView)
    downArrowImageView.snp.makeConstraints { (make) -> Void in
      make.width.equalTo(15)
      make.height.equalTo(15)
      make.centerY.equalTo(pickerShower)
      make.leading.equalTo(pickerTitle.snp.trailing).offset(10)
    }
    

    hourPickerView.setMinMaxHours(minHour: -2, maxHour: 12)
    hourPickerView.snp.makeConstraints { (make) -> Void in
      make.leading.equalTo(self)
      make.top.equalTo(totalTerminalView.snp.bottom)
      make.bottom.equalTo(timerView.snp.top)
      make.trailing.equalTo(self)
    }
    
    timerView.snp.makeConstraints { (make) -> Void in
      make.bottom.equalTo(self)
      make.height.equalTo(UiConstants.Dashboard.progressHeight)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }
    
    picker.alpha = 0.0
    picker.backgroundColor = UIColor.white
    picker.isHidden = true
    picker.snp.makeConstraints { (make) -> Void in
      make.bottom.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }
    
    pickerDismissToolbar.alpha = 0.0
    pickerDismissToolbar.isHidden = true
    pickerDismissToolbar.snp.makeConstraints { (make) -> Void in
      make.width.equalTo(self)
      make.bottom.equalTo(picker.snp.top)
      make.centerX.equalTo(self)
    }
    
    grayView.alpha = UiConstants.TerminalSummary.grayViewAlpha
    grayView.backgroundColor = UIColor.black
    grayView.isHidden = true
    grayView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self)
      make.bottom.equalTo(picker.snp.top)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }
    
    reachabilityNotice.isHidden = ReachabilityManager.sharedInstance.isReachable()
    addSubview(reachabilityNotice)
    reachabilityNotice.snp.makeConstraints { make in
      make.top.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.height.equalTo(UiConstants.ReachabilityNotice.height)
    }
  }
  
  func getCurrentFlightType() -> FlightType {
    return FlightType.all()[picker.selectedRow(inComponent: 0)]
  }
  
  func getCurrentHour() -> Int {
    return hourPickerView.getCurrentHour()
  }
  
  func incrementHour(_ hourChange: Int) {
    hourPickerView.incrementHour(hourChange)
  }
  
  func reloadTerminalViews(_ summaries: [TerminalSummary]) {
    terminalView1.configureForTerminalSummary(summaries.find(.one))
    terminalView2.configureForTerminalSummary(summaries.find(.two))
    terminalView3.configureForTerminalSummary(summaries.find(.three))
    internationalTerminalView.configureForTerminalSummary(summaries.find(.international))
    totalTerminalView.configureTotals(TerminalSummary.getTotals(summaries))
  }
  
  func updatePickerTitle() {
    pickerTitle.text = getCurrentFlightType().asLocalizedString()
  }
  
  func hidePicker() {
    UIView.animate(withDuration: UiConstants.TerminalSummary.fadeDuration, animations: {
      self.picker.alpha = 0.0
      self.pickerDismissToolbar.alpha = 0.0
      self.grayView.alpha = 0.0
    }, completion: { finished in
      self.picker.isHidden = true
      self.pickerDismissToolbar.isHidden = true
      self.grayView.isHidden = true
    })
  }
  
  func showPicker() {
    picker.isHidden = false
    pickerDismissToolbar.isHidden = false
    grayView.isHidden = false
    UIView.animate(withDuration: UiConstants.TerminalSummary.fadeDuration, animations: { () -> Void in
      self.picker.alpha = 1.0
      self.pickerDismissToolbar.alpha = 1.0
      self.grayView.alpha = UiConstants.TerminalSummary.grayViewAlpha
    })
  }
  
  func clearTerminalTable() {
    for terminalView in terminalViews {
      terminalView.clearTotals()
    }
    totalTerminalView.clearTotals()
  }
  
  func setReachabilityNoticeHidden(_ hidden: Bool) {
    reachabilityNotice.isHidden = hidden
  }
  
  func setButtonSelectors(_ target: AnyObject, decreaseAction: Selector, increaseAction: Selector) {
    hourPickerView.setButtonSelectors(target, decreaseAction: decreaseAction, increaseAction: increaseAction)
  }
  
  func startTimerView(_ updateInterval: TimeInterval, callback: @escaping TimerCallback) {
    timerView.start(updateInterval, callback: callback)
  }
  
  func stopTimerView() {
    timerView.stop()
  }
  
  func resetTimerProgess() {
    timerView.resetProgress()
  }
  
  func setTerminalViewSelector(_ target: AnyObject, action: Selector) {
    terminalView1.addTarget(target, action: action, for: .touchUpInside)
    terminalView2.addTarget(target, action: action, for: .touchUpInside)
    terminalView3.addTarget(target, action: action, for: .touchUpInside)
    internationalTerminalView.addTarget(target, action: action, for: .touchUpInside)
  }
  
  func setPickerShowerTarget(_ target: AnyObject, action: Selector) {
    pickerShower.addTarget(target, action: action, for: .touchUpInside)
  }
  
  func setPickerDismisserItems(_ items: [UIBarButtonItem]) {
    pickerDismissToolbar.setItems(items, animated: true)
  }
  
  func setGrayAreaSelector(_ target: AnyObject, action: Selector) {
    grayView.addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
  }
  
  func setPickerDataSourceAndDelegate(dataSource: UIPickerViewDataSource, delegate: UIPickerViewDelegate) {
    picker.dataSource = dataSource
    picker.delegate = delegate
  }
}
