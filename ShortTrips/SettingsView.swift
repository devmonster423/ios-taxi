//
//  SettingsView.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/15/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import SnapKit

class SettingsView: UIView {
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
   
    backgroundColor = UIColor.yellowColor()
  }
}
