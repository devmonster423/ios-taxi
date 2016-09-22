//
//  HourPicker.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit
import SnapKit

class HourPickerView: UIView {
  
  fileprivate var currentHour = 1
  
  fileprivate var maxHour: Int!
  fileprivate var minHour: Int!
  
  fileprivate let decreaseButton = UIButton()
  fileprivate let increaseButton = UIButton()
  
  fileprivate let bottomLabel = UILabel()
  fileprivate let mainLabel = UILabel()
  fileprivate let topLabel = UILabel()

  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = Color.TerminalSummary.offWhite

    addSubview(bottomLabel)
    addSubview(decreaseButton)
    addSubview(increaseButton)
    addSubview(mainLabel)
    addSubview(topLabel)
    
    decreaseButton.setImage(Image.minus.image(), for: UIControlState())
    decreaseButton.setImage(Image.minusPressed.image(), for: .highlighted)
    decreaseButton.snp.makeConstraints { (make) -> Void in
      make.leading.equalTo(self)
      make.centerY.equalTo(self)
      make.height.equalTo(self)
      make.width.equalTo(decreaseButton.snp.height)
    }
    
    increaseButton.setImage(Image.plus.image(), for: UIControlState())
    increaseButton.setImage(Image.plusPressed.image(), for: .highlighted)
    increaseButton.snp.makeConstraints { (make) -> Void in
      make.trailing.equalTo(self)
      make.centerY.equalTo(self)
      make.height.equalTo(self)
      make.width.equalTo(increaseButton.snp.height)
    }
    
    topLabel.font = Font.OpenSansSemibold.size(16)
    topLabel.text = NSLocalizedString("Flights In", comment: "")
    topLabel.textAlignment = .center
    topLabel.textColor = Color.Sfo.blue
    topLabel.snp.makeConstraints { (make) -> Void in
      make.height.equalTo(25)
      make.width.equalTo(100)
      make.centerX.equalTo(self)
      make.bottom.equalTo(mainLabel.snp.top)
    }
    
    mainLabel.font = Font.OpenSansSemibold.size(40)
    mainLabel.text = String(format: NSLocalizedString("%dh", comment: ""), currentHour)
    mainLabel.textAlignment = .center
    mainLabel.textColor = Color.Sfo.blue
    mainLabel.snp.makeConstraints { (make) -> Void in
      make.height.equalTo(40)
      make.width.equalTo(80)
      make.center.equalTo(self)
    }
    
    bottomLabel.font = Font.OpenSansSemibold.size(20)
    bottomLabel.textAlignment = .center
    bottomLabel.textColor = Color.Sfo.blue
    bottomLabel.snp.makeConstraints { (make) -> Void in
      make.height.equalTo(20)
      make.width.equalTo(40)
      make.centerX.equalTo(self)
      make.top.equalTo(mainLabel.snp.bottom)
    }
  }
  
  func getCurrentHour() -> Int {
    return currentHour
  }
  
  func incrementHour(_ hourChange: Int) {
    var hourChange = hourChange
    
    if (hourChange == 1 && currentHour == -1) || (hourChange == -1 && currentHour == 1) {
      hourChange *= 2
    }
    
    let tempHour = currentHour + hourChange
    
    if tempHour >= minHour && tempHour <= maxHour {
      
      currentHour = tempHour
      
      if currentHour < 0 {
        topLabel.text = NSLocalizedString("Flights", comment: "")
        mainLabel.text = String(format: NSLocalizedString("%dh", comment: ""), currentHour * -1)
        bottomLabel.text = NSLocalizedString("Ago", comment: "")
        
      } else if currentHour > 0 {
        topLabel.text = NSLocalizedString("Flights In", comment: "")
        mainLabel.text = String(format: NSLocalizedString("%dh", comment: ""), currentHour)
        bottomLabel.text = ""
      }
    }
    
    if tempHour <= minHour {
      UiHelpers.disableWidgetWithAnimation(decreaseButton)
    } else {
      UiHelpers.enableWidgetWithAnimation(decreaseButton)
    }
    
    if tempHour >= maxHour {
      UiHelpers.disableWidgetWithAnimation(increaseButton)
    } else {
      UiHelpers.enableWidgetWithAnimation(increaseButton)
    }
  }
  
  func setMinMaxHours(minHour: Int, maxHour: Int) {
    self.minHour = minHour
    self.maxHour = maxHour
  }
  
  func setButtonSelectors(_ target: AnyObject, decreaseAction: Selector, increaseAction: Selector) {
    decreaseButton.addTarget(target, action: decreaseAction, for: .touchUpInside)
    increaseButton.addTarget(target, action: increaseAction, for: .touchUpInside)
  }
}
