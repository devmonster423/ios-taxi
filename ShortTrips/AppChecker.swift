//
//  AppChecker.swift
//  ShortTrips
//
//  Created by Matt Luedke on 3/14/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import UIKit

protocol AppChecker {
  func appDidBecomeActive()
  func appChecksSuccessful()
}

extension AppChecker where Self: UIViewController {
  func appDidBecomeActive() {
    if self.isViewLoaded && self.view.window != nil {
      checkVersion()
    }
  }
  
  func showNetworkUnreachableRetry() {
    let alertController = UIAlertController(title: NSLocalizedString("Please check your Internet connection.", comment: ""), message: nil, preferredStyle: .alert)
    let OKAction = UIAlertAction(
      title: NSLocalizedString("Retry", comment: ""),
      style: .default) { _ in
        self.checkVersion()
    }
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
  
  func showErrorRetry() {
    let alertController = UIAlertController(title: NSLocalizedString("Unable to connect to TaxiQ system. Please try again later.", comment: ""), message: nil, preferredStyle: .alert)
    let OKAction = UIAlertAction(
      title: NSLocalizedString("Retry", comment: ""),
      style: .default) { _ in
        self.checkVersion()
    }
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
  
  func checkVersion() {
    
    if !ReachabilityManager.sharedInstance.isReachable() {
      showNetworkUnreachableRetry()
      return
    }
    
    ApiClient.requestVersion { version in
      
      if let version = version {
        if version <= Double(Util.versionString())! {
          // version is fine, proceed with getting terms
          self.checkTerms()
          
        } else {
          // redirect to app store
          let alertController = UIAlertController(title: NSLocalizedString("App version out of date.", comment: ""), message: NSLocalizedString("You will be redirected to the App Store.", comment: ""), preferredStyle: .alert)
          let OKAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""),
            style: .default) { _ in
              
              // go to app store
              UIApplication.shared.openURL(URL(string: "https://itunes.apple.com/us/app/sfo-taxiq/id1096206222?mt=8")!)
          }
          alertController.addAction(OKAction)
          self.present(alertController, animated: true, completion: nil)
        }
      } else {
        self.showErrorRetry()
      }
    }
  }
  
  func checkTerms() {
    ApiClient.requestTermsAndConditions { terms in
      
      if let terms = terms {
        if let agreedTerms = Terms.agreedTerms() , terms == agreedTerms {
          // terms are already approved
          self.appChecksSuccessful()
          
        } else {
          // display terms for agreement
          let alertController = UIAlertController(title: NSLocalizedString("Terms and Conditions", comment: ""), message: NSLocalizedString("By tapping 'I agree' below, you are agreeing to these terms:\n\n", comment: "") + terms, preferredStyle: .alert)
          let OKAction = UIAlertAction(title: "I agree",
            style: .default) { _ in
              Terms.saveTerms(terms)
              self.appChecksSuccessful()
          }
          alertController.addAction(OKAction)
          self.present(alertController, animated: true, completion: nil)
        }
      } else {
        // retry
        let alertController = UIAlertController(title: NSLocalizedString("Required terms and conditions check failed.", comment: ""), message: nil, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: NSLocalizedString("Retry", comment: ""),
          style: .default) { _ in
            self.checkTerms()
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
      }
    }
  }
}
