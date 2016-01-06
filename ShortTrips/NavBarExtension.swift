//
//  NavBarExtension.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/18/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit

extension UIViewController {
  func configureNavBar(background: UIImage = Image.genericBackground.image(), back: Bool = true) {
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    navigationController?.navigationBar.setBackgroundImage(background.stretchableImageWithLeftCapWidth(0, topCapHeight: 0), forBarMetrics: .Default)
    if back {
      navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .Plain, target: self, action: "goBack")
      navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
    }
  }
    
  func goBack() {
    navigationController?.popViewControllerAnimated(true)
  }
}
