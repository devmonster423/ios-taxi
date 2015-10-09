//
//  DebugView.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit
import SnapKit

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
  
  func printDebugLine(text: String?) {
    if let text = text {
      let oldText = debugTextView.text
      debugTextView.text = oldText + "\n" + text
    }
  }
}
