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
      return (Font.MyriadPro.size(20), UIColor.blackColor())
    case .Positive:
      return (Font.MyriadProSemibold.size(20), Color.Debug.green)
    case .Negative:
      return (Font.MyriadProSemibold.size(20), Color.Debug.red)
    case .BigDeal:
      return (Font.MyriadProBold.size(24), UIColor.blackColor())
    }
  }
}

class DebugView: UIView {
  
  private let debugTextView = UITextView()
  private let geofenceLabel = UILabel()
  private let gpsLabel = UILabel()
  let fakeButton = UIButton()
  let logOutButton = UIButton()
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.whiteColor()
    
    addSubview(debugTextView)
    addSubview(geofenceLabel)
    addSubview(gpsLabel)
    addSubview(fakeButton)
    addSubview(logOutButton)
    
    debugTextView.backgroundColor = UIColor(red: 0.95, green: 0.9, blue: 0.9, alpha: 1.0)
    debugTextView.editable = false
    debugTextView.snp_makeConstraints { make in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(logOutButton.snp_top)
      make.top.equalTo(geofenceLabel.snp_bottom)
    }
    
    geofenceLabel.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.5, alpha: 1.0)
    geofenceLabel.font = Font.MyriadPro.size(14)
    geofenceLabel.numberOfLines = 0
    geofenceLabel.text = NSLocalizedString("Last verified geofence(s)", comment: "")
      + ":"
    geofenceLabel.snp_makeConstraints { make in
      make.leading.equalTo(self)
      make.width.equalTo(self).multipliedBy(0.5)
      make.top.equalTo(self).offset(64)
      make.height.equalTo(100)
    }
    
    gpsLabel.backgroundColor = UIColor(red: 0.5, green: 0.95, blue: 0.95, alpha: 1.0)
    gpsLabel.font = Font.MyriadPro.size(14)
    gpsLabel.numberOfLines = 0
    gpsLabel.text = NSLocalizedString("Last verified location", comment: "") + ":"
    gpsLabel.snp_makeConstraints { make in
      make.trailing.equalTo(self)
      make.width.equalTo(geofenceLabel)
      make.top.equalTo(geofenceLabel)
      make.bottom.equalTo(geofenceLabel)
    }
    
    fakeButton.backgroundColor = UIColor.blueColor()
    fakeButton.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(logOutButton)
      make.leading.equalTo(self)
      make.trailing.equalTo(logOutButton.snp_leading)
      make.bottom.equalTo(self)
    }
    
    logOutButton.setTitle(NSLocalizedString("Logout", comment: ""), forState: .Normal)
    logOutButton.backgroundColor = UIColor.redColor()
    logOutButton.snp_makeConstraints { make in
      make.height.equalTo(44)
      make.width.equalTo(80)
      make.bottom.equalTo(self)
      make.trailing.equalTo(self)
    }
  }
  
  func updateGeofenceList(geofences: [Geofence]) {
    var text = NSLocalizedString("Last verified geofence(s)", comment: "") + ":\n"
    
    for geofence in geofences {
      text += geofence.name + "\n"
    }
    
    geofenceLabel.text = text
  }
  
  func updateGPS(latitude: Double, longitude: Double) {
    gpsLabel.text = NSLocalizedString("Last verified location", comment: "")
      + ":\n(\(latitude),\(longitude))"
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
}
