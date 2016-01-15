//
//  LogOutable.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/18/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func addLogoutButton() {
    
    let settingsBtn = UIButton(frame: CGRectMake(0, 0, 44, 44))
    settingsBtn.setImage(Image.gear.image(), forState: .Normal)
    settingsBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 0)
    settingsBtn.addTarget(self,
      action: "logout",
      forControlEvents: .TouchUpInside)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsBtn)
  }
  
  func logout() {
    LoggedOut.sharedInstance.fire()
    DriverCredential.clear()
    self.presentViewController(LoginVC(), animated: true, completion: nil)
  }
}
