//
//  LogOutable.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/18/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func addSettingsAndSecurityButtons() {
    
    let settingsBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    settingsBtn.setImage(Image.gear.image(), for: UIControlState())
    settingsBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 0)
    settingsBtn.addTarget(self,
                          action: #selector(UIViewController.settings),
                          for: .touchUpInside)
    
    let securityBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    securityBtn.setImage(Image.infoCircle.image(), for: UIControlState())
    securityBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 0)
    securityBtn.addTarget(self,
                          action: #selector(UIViewController.security),
                          for: .touchUpInside)
    
    navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: settingsBtn), UIBarButtonItem(customView: securityBtn)]
  }
  
  func security() {
    self.navigationController?.pushViewController(SecurityVC(), animated: true)
  }
  
  func settings() {
    self.navigationController?.pushViewController(SettingsVC(), animated: true)
  }
  
}
