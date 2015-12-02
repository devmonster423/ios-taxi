//
//  LoginVC.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoginVC: UIViewController {
  private let debug: Bool
  
  convenience init() {
    self.init(debug: false)
  }
  
  init(debug: Bool) {
    self.debug = debug
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    let loginView = LoginView(frame: UIScreen.mainScreen().bounds)
    loginView.loginButton.addTarget(self,
      action: "login",
      forControlEvents: .TouchUpInside)
    view = loginView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let credential = DriverCredential.load() {
      loginView().prefill(credential.username, password: credential.password)
      login()
    }
  }

  func loginView() -> LoginView {
    return self.view as! LoginView
  }
  
  func login() {
    let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
    hud.labelText = NSLocalizedString("Logging In...", comment: "")
    ApiClient.authenticateDriver(loginView().getLoginCredential()) { credential, driver in
      
      hud.hide(true)
      
      if let driver = driver {
        credential.save()
        DriverManager.sharedInstance.setCurrentDriver(driver)
        if (self.debug) {
          self.navigationController?.pushViewController(DebugVC(), animated: true)
        }
        else {
          self.navigationController?.pushViewController(ShortTripVC(), animated: true)
        }
      } else {
        let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""),
          message: NSLocalizedString("An error occurred while logging in.", comment: ""),
          preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""),
          style: .Default, handler: nil)
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
      }
    }
  }
}
