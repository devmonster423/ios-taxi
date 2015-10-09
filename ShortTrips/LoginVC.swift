//
//  LoginVC.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
  
  override func loadView() {
    let dashboardView = LoginView(frame: UIScreen.mainScreen().bounds)
    view = dashboardView
  }

  func loginView() -> LoginView {
    return self.view as! LoginView
  }
}
