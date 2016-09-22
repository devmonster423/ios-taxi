//
//  DebugView.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit
import SnapKit

enum DebugType {
  case normal
  case positive
  case negative
  case bigDeal
  
  func fontAndColor() -> (font: UIFont, color: UIColor) {
    switch self {
    case .normal:
      return (Font.OpenSans.size(20), UIColor.black)
    case .positive:
      return (Font.OpenSansSemibold.size(20), Color.Debug.green)
    case .negative:
      return (Font.OpenSansSemibold.size(20), Color.Debug.red)
    case .bigDeal:
      return (Font.OpenSansBold.size(24), UIColor.black)
    }
  }
}

class DebugView: UIView {
  
  fileprivate let debugTextView = UITextView()
  fileprivate let geofenceLabel = UILabel()
  fileprivate let gpsLabel = UILabel()
  fileprivate let stateLabel = UILabel()
  fileprivate let gtmsLabel = UILabel()
  fileprivate let cidLabel = UILabel()
  fileprivate let aviLabel = UILabel()
  fileprivate let reachabilityNotice = ReachabilityNotice()
  fileprivate var gtmsCount: Int = 0
  
  let fakeButton = UIButton()
  let secondFakeButton = UIButton()
  let thirdFakeButton = UIButton()
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.white
    
    addSubview(debugTextView)
    addSubview(geofenceLabel)
    addSubview(gpsLabel)
    addSubview(stateLabel)
    addSubview(gtmsLabel)
    addSubview(fakeButton)
    addSubview(secondFakeButton)
    addSubview(thirdFakeButton)
    addSubview(cidLabel)
    addSubview(aviLabel)
    
    debugTextView.backgroundColor = UIColor(red: 0.95, green: 0.9, blue: 0.9, alpha: 1.0)
    debugTextView.isEditable = false
    debugTextView.snp.makeConstraints { make in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(fakeButton.snp.top)
      make.top.equalTo(stateLabel.snp.bottom)
    }
    
    geofenceLabel.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.5, alpha: 1.0)
    geofenceLabel.font = Font.OpenSans.size(14)
    geofenceLabel.numberOfLines = 0
    geofenceLabel.text = NSLocalizedString("Last verified geofence(s)", comment: "")
      + ":"
    geofenceLabel.snp.makeConstraints { make in
      make.leading.equalTo(self)
      make.width.equalTo(self).multipliedBy(0.5)
      make.top.equalTo(self)
      make.height.equalTo(100)
    }
    
    gpsLabel.backgroundColor = UIColor(red: 0.5, green: 0.95, blue: 0.95, alpha: 1.0)
    gpsLabel.font = Font.OpenSans.size(14)
    gpsLabel.numberOfLines = 0
    gpsLabel.text = NSLocalizedString("Last verified location", comment: "") + ":"
    gpsLabel.snp.makeConstraints { make in
      make.trailing.equalTo(self)
      make.width.equalTo(geofenceLabel)
      make.top.equalTo(geofenceLabel)
      make.bottom.equalTo(geofenceLabel)
    }
    
    stateLabel.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
    stateLabel.font = Font.OpenSans.size(14)
    stateLabel.numberOfLines = 0
    stateLabel.snp.makeConstraints { make in
      make.height.equalTo(50)
      make.leading.equalTo(self)
      make.width.equalTo(self).dividedBy(2)
      make.top.equalTo(geofenceLabel.snp.bottom)
    }
    
    gtmsLabel.backgroundColor = UIColor(red: 0.90, green: 0.20, blue: 0.90, alpha: 1.0)
    gtmsLabel.font = Font.OpenSans.size(14)
    gtmsLabel.numberOfLines = 0
    updateGtms()
    gtmsLabel.snp.makeConstraints { make in
      make.height.equalTo(50)
      make.trailing.equalTo(self)
      make.width.equalTo(self).dividedBy(2)
      make.top.equalTo(geofenceLabel.snp.bottom)
    }
    
    cidLabel.backgroundColor = UIColor(red: 0.25, green: 0.25, blue: 0.95, alpha: 1.0)
    cidLabel.font = Font.OpenSans.size(14)
    cidLabel.textColor = UIColor.white
    cidLabel.numberOfLines = 0
    cidLabel.text = NSLocalizedString("Last CID", comment: "") + ":"
    cidLabel.snp.makeConstraints { make in
      make.height.equalTo(80)
      make.leading.equalTo(self)
      make.width.equalTo(self).dividedBy(2)
      make.top.equalTo(stateLabel.snp.bottom)
    }
    
    aviLabel.backgroundColor = UIColor(red: 0.95, green: 0.25, blue: 0.5, alpha: 1.0)
    aviLabel.font = Font.OpenSans.size(14)
    aviLabel.textColor = UIColor.white
    aviLabel.numberOfLines = 0
    aviLabel.text = NSLocalizedString("Last AVI", comment: "") + ":"
    aviLabel.snp.makeConstraints { make in
      make.height.equalTo(80)
      make.trailing.equalTo(self)
      make.width.equalTo(self).dividedBy(2)
      make.top.equalTo(stateLabel.snp.bottom)
    }

    fakeButton.backgroundColor = UIColor.blue
    fakeButton.snp.makeConstraints { make in
      make.height.equalTo(44)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(secondFakeButton.snp.top)
    }

    secondFakeButton.backgroundColor = UIColor(red: 0.25, green: 0.5, blue: 0.5, alpha: 1.0)
    secondFakeButton.titleLabel?.font = Font.OpenSans.size(12)
    secondFakeButton.titleLabel?.numberOfLines = 2
    secondFakeButton.snp.makeConstraints { (make) -> Void in
      make.height.equalTo(44)
      make.leading.equalTo(self)
      make.width.equalTo(self).dividedBy(2)
      make.bottom.equalTo(self)
    }

    thirdFakeButton.backgroundColor = UIColor.black
    thirdFakeButton.titleLabel?.font = Font.OpenSans.size(12)
    thirdFakeButton.snp.makeConstraints { (make) -> Void in
      make.height.equalTo(secondFakeButton)
      make.leading.equalTo(secondFakeButton.snp.trailing)
      make.width.equalTo(self).dividedBy(2)
      make.bottom.equalTo(self)
    }
    
    addSubview(reachabilityNotice)
    reachabilityNotice.snp.makeConstraints { make in
      make.height.equalTo(UiConstants.ReachabilityNotice.height)
      make.top.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }
  }
  
  func incrementGtms() {
    gtmsCount += 1
    updateGtms()
  }
  
  func updateGeofenceList(_ geofences: [SfoGeofence]) {
    var text = NSLocalizedString("Last verified geofence(s)", comment: "") + ":\n"
    
    for geofence in geofences {
      text += "\(geofence)" + "\n"
    }
    
    geofenceLabel.text = text
  }
  
  func updateGPS(_ latitude: Double, longitude: Double) {
    gpsLabel.text = NSLocalizedString("Last verified location", comment: "")
      + ":\n(\(latitude),\(longitude))"
  }
  
  func updateState(_ text: String?) {
    if let text = text {
      stateLabel.text = NSLocalizedString("State", comment: "") + ": \(text)"
    }
  }
  
  func updateCid(_ text: String?) {
    if let text = text {
      cidLabel.text = NSLocalizedString("Last CID", comment: "") + ": \(text)"
    }
  }

  func updateGtms() {
      gtmsLabel.text = NSLocalizedString("GTMS calls", comment: "") + ": \(gtmsCount)"
  }
  
  func updateAvi(_ text: String?) {
    if let text = text {
      aviLabel.text = NSLocalizedString("Last AVI", comment: "") + ": \(text)"
    }
  }
  
  func printDebugLine(_ text: String?, type: DebugType = .normal) {
    if let text = text {
      
      let newString = NSMutableAttributedString(attributedString: debugTextView.attributedText)
      
      let fontAndColor = type.fontAndColor()
      
      let attributedText = NSAttributedString(string: "\n" + text,
        attributes: [
          NSFontAttributeName: fontAndColor.font,
          NSForegroundColorAttributeName: fontAndColor.color
        ])
      
      newString.append(attributedText)
      debugTextView.attributedText = newString
      debugTextView.scrollRangeToVisible(NSMakeRange(newString.length, 0))
      
      print(text)
    }
  }
  
  func setReachabilityNoticeHidden(_ hidden: Bool) {
    reachabilityNotice.isHidden = hidden
  }
}
