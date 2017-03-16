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
  fileprivate let credential: DriverCredential?
  fileprivate let startup: Bool
  
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
      let loginView = LoginView(frame: UIScreen.main.bounds)
      view = loginView
    } else {
      let loginView = LoginView(frame: UIScreen.main.bounds)
      loginView.loginButton.addTarget(self,
        action: #selector(LoginVC.login),
        for: .touchUpInside)
      view = loginView
      loginView.usernameTextField.becomeFirstResponder()
    }
  }
  
  func loginView() -> LoginView {
    return self.view as! LoginView
  }
  
  func loginIfCredentialsExist() {
    if let _ = credential {
      login()
    }
  }

  func login() {
    
    let optionalCredential = self.credential ?? loginView().getLoginCredential()
    
    guard let fullCredential = optionalCredential else { return }
    
    let hud = MBProgressHUD.showAdded(to: view, animated: true)
    hud.label.text = NSLocalizedString("Logging In...", comment: "")
    ApiClient.authenticateDriver(fullCredential) { driver in
      
      hud.hide(animated: true)
      
      if let driver = driver {
        fullCredential.save()
        DriverManager.sharedInstance.setCurrentDriver(driver)
        NotificationManager.refreshAll()
        
        if self.startup {
          self.present(MainTabBarController, animated: false, completion: nil)
          
        } else {
          self.dismiss(animated: true, completion: nil)
        }
        
      } else {
        let alertController = UIAlertController(title: "",
          message: NSLocalizedString("An error occurred while logging in.", comment: ""),
          preferredStyle: .alert)
        let OKAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""),
          style: .default) { _ in
            if let _ = self.credential {
              DriverCredential.clear()
              self.present(LoginVC(startup: true), animated: true, completion: nil)
            }
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
      }
    }
  }
}

extension LoginVC: AppChecker {
  func appChecksSuccessful() {
    loginIfCredentialsExist()
  }
}
