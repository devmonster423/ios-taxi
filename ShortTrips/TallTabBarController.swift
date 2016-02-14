//
//  TallTabBarController.swift
//  ShortTrips
//
//  Created by Joshua Adams on 2/10/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import UIKit

class TallTabBarController: UITabBarController {
  override func viewWillLayoutSubviews() {
    var tabFrame = self.tabBar.frame
    tabFrame.size.height = UiConstants.TabBarController.height
    tabFrame.origin.y = self.view.frame.size.height - UiConstants.TabBarController.height
    self.tabBar.frame = tabFrame
  }
}
