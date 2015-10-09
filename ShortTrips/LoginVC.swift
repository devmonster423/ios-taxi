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
    let loginView = LoginView(frame: UIScreen.mainScreen().bounds)
    loginView.loginButton.addTarget(self,
      action: "login",
      forControlEvents: .TouchUpInside)
    view = loginView
  }

  func loginView() -> LoginView {
    return self.view as! LoginView
  }
  
  func login() {
    ApiClient.authenticateDriver(loginView().getLoginCredential()) { _ in
      
      // TODO: pass along/save credentials
      navigationController?.pushViewController(DebugVC(), animated: true)
    }
  }
}
