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
    
    let settingsBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    settingsBtn.setImage(Image.gear.image(), for: UIControlState())
    settingsBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 0)
    settingsBtn.addTarget(self,
      action: #selector(UIViewController.settings),
      for: .touchUpInside)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsBtn)
  }
  
  func settings() {
    self.navigationController?.pushViewController(SettingsVC(), animated: true)
  }
}
