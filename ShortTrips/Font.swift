//
//  UIFont+SFO.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/20/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit

enum Font: String {
  case MyriadPro = "MyriadPro-Regular"
  case MyriadProBold = "MyriadPro-Bold"
  case MyriadProSemibold = "MyriadPro-Semibold"
  
  func size(size: CGFloat) -> UIFont {
    return UIFont(name: self.rawValue, size: size)!
  }
}
