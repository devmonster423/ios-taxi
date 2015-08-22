//
//  UIImage+initWithColor.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/21/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
  public class func imageWithColor(color: UIColor) -> UIImage {
    let rect = CGRectMake(0, 0, 1, 1)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
    color.setFill()
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
}
