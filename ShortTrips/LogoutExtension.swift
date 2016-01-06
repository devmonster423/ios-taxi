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
    //UIView.appearance().tintColor = UIColor.whiteColor()
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout",
      style: .Plain,
      target: self,
      action: "logout")
    navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
  }
  
  func logout() {
    LoggedOut.sharedInstance.fire()
    DriverCredential.clear()
    self.presentViewController(LoginVC(), animated: true, completion: nil)
  }
}
