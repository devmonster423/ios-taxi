//
//  SettingsVC.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/15/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import UIKit

enum SettingsSection: Int {
  case Audio = 0
  case Faq = 1
  case Logout = 2
}

class SettingsVC: UIViewController {
  
  let cellId = "cell"
  
  override func loadView() {
    let settingsView = SettingsView(frame: UIScreen.mainScreen().bounds)
    settingsView.tableView.dataSource = self
    settingsView.tableView.delegate = self
    view = settingsView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureNavBar(back: true, title: NSLocalizedString("Settings", comment: "").uppercaseString)
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    let settingsView = view as! SettingsView
    settingsView.tableView.reloadData()
  }
  
  func showLogoutConfirm() {
    let alertController = UIAlertController(title: NSLocalizedString("Are you sure?", comment: ""),
      message: "",
      preferredStyle: .Alert)
    
    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .Cancel, handler: nil)
    alertController.addAction(cancelAction)
    
    let logoutAction = UIAlertAction(title: NSLocalizedString("Logout", comment: ""), style: .Default) { (action) in
      self.logout()
    }
    alertController.addAction(logoutAction)
    
    presentViewController(alertController, animated: true, completion: nil)
  }
  
  func logout() {
    LoggedOut.sharedInstance.fire()
    DriverCredential.clear()
    self.presentViewController(LoginVC(), animated: true, completion: nil)
  }
}

extension SettingsVC: UITableViewDataSource {
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 3
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch SettingsSection(rawValue: section)! {
    case .Audio:
      return 1
    case .Faq:
      return 1
    case .Logout:
      return 1
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = UITableViewCell(style: .Default, reuseIdentifier: cellId)
    cell.selectionStyle = .None
    
    switch SettingsSection(rawValue: indexPath.section)! {
    case .Audio:
      cell.textLabel?.text = Speaker.sharedInstance.audioEnabled
        ? NSLocalizedString("Audio ON. Tap to turn off.", comment: "")
        : NSLocalizedString("Audio OFF. Tap to turn on.", comment: "")
    case .Faq:
      cell.textLabel?.text = NSLocalizedString("Frequently Asked Questions", comment: "")
    case .Logout:
      cell.textLabel?.text = NSLocalizedString("Logout", comment: "")
      let credentials = NSURLCredentialStorage.sharedCredentialStorage()
        .credentialsForProtectionSpace(DriverCredential.credentialProtectionSpace())
      if let username = credentials?.first?.1.user {
        cell.textLabel?.text = NSLocalizedString("Logout", comment: "") + " " + username
      }
      else {
        cell.textLabel?.text = NSLocalizedString("Logout", comment: "")
      }
    }
    
    return cell
  }
}

extension SettingsVC: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    switch SettingsSection(rawValue: indexPath.section)! {
    case .Audio:
      Speaker.sharedInstance.audioEnabled = !Speaker.sharedInstance.audioEnabled
      tableView.reloadData()
    case .Faq:
      UiHelpers.displayComingSoonMessage(self)
    case .Logout:
      showLogoutConfirm()
    }
  }
}
