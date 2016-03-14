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
      loginView.usernameTextField.becomeFirstResponder()
    }
  }
  
  func loginView() -> LoginView {
    return self.view as! LoginView
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    checkVersion()
  }
  
  func checkVersion() {
  
    let versionString = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
    
    ApiClient.requestVersion { version in
      
      if let version = version {
        if version <= Double(versionString) {
          // version is fine, proceed with getting terms
          self.checkTerms()
          
        } else {
          // redirect to app store
          let alertController = UIAlertController(title: NSLocalizedString("App version out of date.", comment: ""), message: NSLocalizedString("You will be redirected to the App Store.", comment: ""), preferredStyle: .Alert)
          let OKAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""),
            style: .Default) { _ in
              
              // go to app store
          }
          alertController.addAction(OKAction)
          self.presentViewController(alertController, animated: true, completion: nil)
        }
      } else {
        // request failed, offer to retry
        let alertController = UIAlertController(title: NSLocalizedString("Required version check failed.", comment: ""), message: nil, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: NSLocalizedString("Retry", comment: ""),
          style: .Default) { _ in
            self.checkVersion()
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
      }
    }
  }

  func checkTerms() {
    ApiClient.requestTermsAndConditions { terms in
      
      if let terms = terms {
        if let agreedTerms = Terms.agreedTerms() where terms == agreedTerms {
          // terms are already approved
          self.loginIfCredentialsExist()
          
        } else {
          // display terms for agreement
          let alertController = UIAlertController(title: NSLocalizedString("Terms and Conditions", comment: ""), message: NSLocalizedString("By tapping 'I agree' below, you are agreeing to these terms:\n\n", comment: "") + terms, preferredStyle: .Alert)
          let OKAction = UIAlertAction(title: "I agree",
            style: .Default) { _ in
              Terms.saveTerms(terms)
              self.loginIfCredentialsExist()
          }
          alertController.addAction(OKAction)
          self.presentViewController(alertController, animated: true, completion: nil)
        }
      } else {
        // retry
        let alertController = UIAlertController(title: NSLocalizedString("Required terms and conditions check failed.", comment: ""), message: nil, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: NSLocalizedString("Retry", comment: ""),
          style: .Default) { _ in
            self.checkTerms()
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
      }
    }
  }

  func loginIfCredentialsExist() {
    if let _ = credential {
      login()
    }
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
