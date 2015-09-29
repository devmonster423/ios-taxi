//
//  UIButton+positionLabel.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/24/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
  func centerLabel() {
    let imageSize = self.imageView!.frame.size
    self.titleEdgeInsets = UIEdgeInsets(top:0, left:-imageSize.width, bottom:-(imageSize.height + 6.0), right:0)
  }
  
  func centerLabelVerticallyWithPadding(spacing: CGFloat) {
    let imageSize = self.imageView!.frame.size
    self.titleEdgeInsets = UIEdgeInsets(top:0, left:-imageSize.width, bottom:-(imageSize.height + spacing), right:0)
    let titleSize = self.titleLabel!.frame.size
    self.imageEdgeInsets = UIEdgeInsets(top:-(titleSize.height + spacing), left:0, bottom: 0, right:-titleSize.width)
    let trueContentSize = CGRectUnion(self.titleLabel!.frame, self.imageView!.frame).size
    let oldContentSize = self.intrinsicContentSize()
    let heightDelta = trueContentSize.height - oldContentSize.height
    let widthDelta = trueContentSize.width - oldContentSize.width
    self.contentEdgeInsets = UIEdgeInsets(top:heightDelta/2.0, left:widthDelta/2.0, bottom:heightDelta/2.0, right:widthDelta/2.0)
  }
}