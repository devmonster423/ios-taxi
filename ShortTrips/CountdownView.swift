//
//  File.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/12/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CountdownView: UIView {
  
  private let countdownLabel = UILabel()
  private var numberFormatter: NSNumberFormatter {
    let formatter = NSNumberFormatter()
    formatter.minimumIntegerDigits = 2
    return formatter
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
   
    addSubview(countdownLabel)
    
    backgroundColor = Color.Trip.Time.background
    
    countdownLabel.font = Font.OpenSansBold.size(36)
    countdownLabel.textAlignment = .Center
    countdownLabel.textColor = Color.Trip.Time.title
    countdownLabel.snp_makeConstraints { make in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.height.equalTo(self).dividedBy(2.5)
      make.bottom.equalTo(self).offset(-5)
    }
    
    let countdownSubtitleLabel = UILabel()
    countdownSubtitleLabel.font = Font.OpenSansSemibold.size(18)
    countdownSubtitleLabel.text = NSLocalizedString("Short Trip expires in", comment: "").uppercaseString
    countdownSubtitleLabel.textAlignment = .Center
    countdownSubtitleLabel.textColor = Color.Trip.Time.subtitle
    addSubview(countdownSubtitleLabel)
    countdownSubtitleLabel.snp_makeConstraints { make in
      make.leading.equalTo(countdownLabel)
      make.trailing.equalTo(countdownLabel)
      make.height.equalTo(self).dividedBy(2.5)
      make.top.equalTo(self).offset(5)
    }
  }
  
  func updateCountdown(elapsedTime: NSTimeInterval?) {
    if let elapsedTime = elapsedTime {
      let remainingTime = Int(2 * 60 * 60 - elapsedTime)
      let remainingHours = Int(remainingTime / (60 * 60))
      let remainingMinutes = Int((remainingTime - remainingHours * 60 * 60) / 60)
      let remainingSeconds = Int(remainingTime - remainingHours * 60 * 60 - remainingMinutes * 60)
      
      countdownLabel.text = "\(remainingHours)h \(numberFormatter.stringFromNumber(remainingMinutes)!)m \(numberFormatter.stringFromNumber(remainingSeconds)!)s"
    } else {
      countdownLabel.text = ""
    }
  }
}
