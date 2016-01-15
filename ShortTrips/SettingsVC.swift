//
//  SettingsVC.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/15/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
  
  override func loadView() {
    let settingsView = SettingsView(frame: UIScreen.mainScreen().bounds)
    
    view = settingsView
  }
  
  func logout() {
    LoggedOut.sharedInstance.fire()
    DriverCredential.clear()
    self.presentViewController(LoginVC(), animated: true, completion: nil)
  }
}
