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
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.whiteColor()
    
    addSubview(debugTextView)
    
    debugTextView.backgroundColor = UIColor(red: 0.95, green: 0.9, blue: 0.9, alpha: 1.0)
    debugTextView.font = Font.MyriadPro.size(20)
    debugTextView.snp_makeConstraints { make in
      make.edges.equalTo(self)
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
    }
  }
}
