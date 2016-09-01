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
  case Normal
  case Positive
  case Negative
  case BigDeal
  
  func fontAndColor() -> (font: UIFont, color: UIColor) {
    switch self {
    case .Normal:
      return (Font.OpenSans.size(20), UIColor.blackColor())
    case .Positive:
      return (Font.OpenSansSemibold.size(20), Color.Debug.green)
    case .Negative:
      return (Font.OpenSansSemibold.size(20), Color.Debug.red)
    case .BigDeal:
      return (Font.OpenSansBold.size(24), UIColor.blackColor())
    }
  }
}

class DebugView: UIView {
  
  private let debugTextView = UITextView()
  private let geofenceLabel = UILabel()
  private let gpsLabel = UILabel()
  private let stateLabel = UILabel()
  private let gtmsLabel = UILabel()
  private let cidLabel = UILabel()
  private let aviLabel = UILabel()
  private let reachabilityNotice = ReachabilityNotice()
  private var gtmsCount: Int = 0
  
  let fakeButton = UIButton()
  let secondFakeButton = UIButton()
  let thirdFakeButton = UIButton()
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.whiteColor()
    
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
    debugTextView.editable = false
    debugTextView.snp_makeConstraints { make in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(fakeButton.snp_top)
      make.top.equalTo(stateLabel.snp_bottom)
    }
    
    geofenceLabel.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.5, alpha: 1.0)
    geofenceLabel.font = Font.OpenSans.size(14)
    geofenceLabel.numberOfLines = 0
    geofenceLabel.text = NSLocalizedString("Last verified geofence(s)", comment: "")
      + ":"
    geofenceLabel.snp_makeConstraints { make in
      make.leading.equalTo(self)
      make.width.equalTo(self).multipliedBy(0.5)
      make.top.equalTo(self)
      make.height.equalTo(100)
    }
    
    gpsLabel.backgroundColor = UIColor(red: 0.5, green: 0.95, blue: 0.95, alpha: 1.0)
    gpsLabel.font = Font.OpenSans.size(14)
    gpsLabel.numberOfLines = 0
    gpsLabel.text = NSLocalizedString("Last verified location", comment: "") + ":"
    gpsLabel.snp_makeConstraints { make in
      make.trailing.equalTo(self)
      make.width.equalTo(geofenceLabel)
      make.top.equalTo(geofenceLabel)
      make.bottom.equalTo(geofenceLabel)
    }
    
    stateLabel.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
    stateLabel.font = Font.OpenSans.size(14)
    stateLabel.numberOfLines = 0
    stateLabel.snp_makeConstraints { make in
      make.height.equalTo(50)
      make.leading.equalTo(self)
      make.width.equalTo(self).dividedBy(2)
      make.top.equalTo(geofenceLabel.snp_bottom)
    }
    
    gtmsLabel.backgroundColor = UIColor(red: 0.90, green: 0.20, blue: 0.90, alpha: 1.0)
    gtmsLabel.font = Font.OpenSans.size(14)
    gtmsLabel.numberOfLines = 0
    updateGtms()
    gtmsLabel.snp_makeConstraints { make in
      make.height.equalTo(50)
      make.trailing.equalTo(self)
      make.width.equalTo(self).dividedBy(2)
      make.top.equalTo(geofenceLabel.snp_bottom)
    }
    
    cidLabel.backgroundColor = UIColor(red: 0.25, green: 0.25, blue: 0.95, alpha: 1.0)
    cidLabel.font = Font.OpenSans.size(14)
    cidLabel.textColor = UIColor.whiteColor()
    cidLabel.numberOfLines = 0
    cidLabel.text = NSLocalizedString("Last CID", comment: "") + ":"
    cidLabel.snp_makeConstraints { make in
      make.height.equalTo(80)
      make.leading.equalTo(self)
      make.width.equalTo(self).dividedBy(2)
      make.top.equalTo(stateLabel.snp_bottom)
    }
    
    aviLabel.backgroundColor = UIColor(red: 0.95, green: 0.25, blue: 0.5, alpha: 1.0)
    aviLabel.font = Font.OpenSans.size(14)
    aviLabel.textColor = UIColor.whiteColor()
    aviLabel.numberOfLines = 0
    aviLabel.text = NSLocalizedString("Last AVI", comment: "") + ":"
    aviLabel.snp_makeConstraints { make in
      make.height.equalTo(80)
      make.trailing.equalTo(self)
      make.width.equalTo(self).dividedBy(2)
      make.top.equalTo(stateLabel.snp_bottom)
    }

    fakeButton.backgroundColor = UIColor.blueColor()
    fakeButton.snp_makeConstraints { make in
      make.height.equalTo(44)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(secondFakeButton.snp_top)
    }

    secondFakeButton.backgroundColor = UIColor(red: 0.25, green: 0.5, blue: 0.5, alpha: 1.0)
    secondFakeButton.titleLabel?.font = Font.OpenSans.size(12)
    secondFakeButton.titleLabel?.numberOfLines = 2
    secondFakeButton.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(44)
      make.leading.equalTo(self)
      make.width.equalTo(self).dividedBy(2)
      make.bottom.equalTo(self)
    }

    thirdFakeButton.backgroundColor = UIColor.blackColor()
    thirdFakeButton.titleLabel?.font = Font.OpenSans.size(12)
    thirdFakeButton.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(secondFakeButton)
      make.leading.equalTo(secondFakeButton.snp_trailing)
      make.width.equalTo(self).dividedBy(2)
      make.bottom.equalTo(self)
    }
    
    addSubview(reachabilityNotice)
    reachabilityNotice.snp_makeConstraints { make in
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
  
  func updateGeofenceList(geofences: [SfoGeofence]) {
    var text = NSLocalizedString("Last verified geofence(s)", comment: "") + ":\n"
    
    for geofence in geofences {
      text += "\(geofence)" + "\n"
    }
    
    geofenceLabel.text = text
  }
  
  func updateGPS(latitude: Double, longitude: Double) {
    gpsLabel.text = NSLocalizedString("Last verified location", comment: "")
      + ":\n(\(latitude),\(longitude))"
  }
  
  func updateState(text: String?) {
    if let text = text {
      stateLabel.text = NSLocalizedString("State", comment: "") + ": \(text)"
    }
  }
  
  func updateCid(text: String?) {
    if let text = text {
      cidLabel.text = NSLocalizedString("Last CID", comment: "") + ": \(text)"
    }
  }

  func updateGtms() {
      gtmsLabel.text = NSLocalizedString("GTMS calls", comment: "") + ": \(gtmsCount)"
  }
  
  func updateAvi(text: String?) {
    if let text = text {
      aviLabel.text = NSLocalizedString("Last AVI", comment: "") + ": \(text)"
    }
  }
  
  func printDebugLine(text: String?, type: DebugType = .Normal) {
    if let text = text {
      
      let newString = NSMutableAttributedString(attributedString: debugTextView.attributedText)
      
      let fontAndColor = type.fontAndColor()
      
      let attributedText = NSAttributedString(string: "\n" + text,
        attributes: [
          NSFontAttributeName: fontAndColor.font,
          NSForegroundColorAttributeName: fontAndColor.color
        ])
      
      newString.appendAttributedString(attributedText)
      debugTextView.attributedText = newString
      debugTextView.scrollRangeToVisible(NSMakeRange(newString.length, 0))
      
      print(text)
    }
  }
  
  func setReachabilityNoticeHidden(hidden: Bool) {
    reachabilityNotice.hidden = hidden
  }
}
