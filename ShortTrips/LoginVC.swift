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
  private let credential: DriverCredential?
  private let startup: Bool
  
  init(startup: Bool = false) {
    self.credential = DriverCredential.load()
    self.startup = startup
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    if let _ = credential {
      let loginView = AutoLoginView(frame: UIScreen.mainScreen().bounds)
      view = loginView
    } else {
      let loginView = LoginView(frame: UIScreen.mainScreen().bounds)
      loginView.loginButton.addTarget(self,
        action: "login",
        forControlEvents: .TouchUpInside)
      view = loginView
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let _ = credential {
      login()
    }
  }

  func loginView() -> LoginView {
    return self.view as! LoginView
  }
  
  func login() {
    
    let credential = self.credential ?? loginView().getLoginCredential()
    
    let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
    hud.labelText = NSLocalizedString("Logging In...", comment: "")
    ApiClient.authenticateDriver(credential) { driver in
      
      hud.hide(true)
      
      if let driver = driver {
        credential.save()
        DriverManager.sharedInstance.setCurrentDriver(driver)
        
        if self.startup {
          self.presentViewController(MainTabBarController, animated: false, completion: nil)
          
        } else {
          self.dismissViewControllerAnimated(true, completion: nil)
        }
        
      } else {
        let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""),
          message: NSLocalizedString("An error occurred while logging in.", comment: ""),
          preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""),
          style: .Default) { _ in
            if let _ = self.credential {
              DriverCredential.clear()
              self.presentViewController(LoginVC(startup: true), animated: true, completion: nil)
            }
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
      }
    }
  }
}
