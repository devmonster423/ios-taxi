//
//  LogOutable.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/18/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func addSettingsButton() {
    
    let settingsBtn = UIButton(frame: CGRectMake(0, 0, 44, 44))
    settingsBtn.setImage(Image.gear.image(), forState: .Normal)
    settingsBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 0)
    settingsBtn.addTarget(self,
      action: "settings",
      forControlEvents: .TouchUpInside)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsBtn)
  }
  
  func settings() {
    self.navigationController?.pushViewController(SettingsVC(), animated: true)
  }
}
