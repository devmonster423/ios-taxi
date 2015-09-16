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
  
  private var currentHour = 0
  
  var maxHour: Int!
  var minHour: Int!
  
  let decreaseButton = UIButton()
  let increaseButton = UIButton()
  
  private let bottomLabel = UILabel()
  private let mainLabel = UILabel()
  private let topLabel = UILabel()

  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(bottomLabel)
    addSubview(decreaseButton)
    addSubview(increaseButton)
    addSubview(mainLabel)
    addSubview(topLabel)
    
    decreaseButton.setImage(UIImage(named: "minus"), forState: .Normal)
    decreaseButton.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(self)
      make.centerY.equalTo(self)
      make.height.equalTo(self)
      make.width.equalTo(decreaseButton.snp_height)
    }
    
    increaseButton.setImage(UIImage(named: "plus"), forState: .Normal)
    increaseButton.snp_makeConstraints { (make) -> Void in
      make.trailing.equalTo(self)
      make.centerY.equalTo(self)
      make.height.equalTo(self)
      make.width.equalTo(increaseButton.snp_height)
    }
    
    topLabel.text = NSLocalizedString("Flights", comment: "")
    topLabel.textAlignment = .Center
    topLabel.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(20)
      make.width.equalTo(80)
      make.centerX.equalTo(self)
      make.bottom.equalTo(mainLabel.snp_top).offset(-10)
    }
    
    mainLabel.text = NSLocalizedString("Now", comment: "")
    mainLabel.textAlignment = .Center
    mainLabel.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(40)
      make.width.equalTo(50)
      make.center.equalTo(self)
    }
    
    bottomLabel.textAlignment = .Center
    bottomLabel.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(20)
      make.width.equalTo(40)
      make.centerX.equalTo(self)
      make.top.equalTo(mainLabel.snp_bottom)
    }
  }
  
  func getCurrentHour() -> Int {
    return currentHour
  }
  
  func incrementHour(hourChange: Int) {
    
    let tempHour = currentHour + hourChange
    
    if tempHour >= minHour && tempHour <= maxHour {
      
      currentHour = tempHour
      
      if currentHour == 0 {
        topLabel.text = NSLocalizedString("Flights", comment: "")
        mainLabel.text = NSLocalizedString("Now", comment: "")
        bottomLabel.text = ""
        
      } else if currentHour < 0 {
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
}