//
//  SettingsVC.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/15/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import UIKit
import MessageUI

enum SettingsSection: Int {
  case Audio = 0
  case Feedback = 1
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
    let originalSetting = Speaker.sharedInstance.getAudioEnabled()
    if TripManager.sharedInstance.getTripId() == nil {
      Speaker.sharedInstance.setAudioEnabled(false)
    }
    
    LoggedOut.sharedInstance.fire()
    DriverCredential.clear()
    DriverManager.sharedInstance.setCurrentDriver(nil)
    DriverManager.sharedInstance.setCurrentVehicle(nil)
    self.presentViewController(LoginVC(), animated: true, completion: nil)
    
    Speaker.sharedInstance.setAudioEnabled(originalSetting)
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
    case .Feedback:
      return 1
    case .Logout:
      return 1
    }
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch SettingsSection(rawValue: section)! {
    case .Logout:
      if let name = DriverManager.sharedInstance.getCurrentDriver()?.fullName() {
        return NSLocalizedString("Logged in as: ", comment: "") + name
      } else {
        return nil
      }
    default:
      return nil
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = UITableViewCell(style: .Default, reuseIdentifier: cellId)
    cell.selectionStyle = .None
    
    switch SettingsSection(rawValue: indexPath.section)! {
    case .Audio:
      cell.textLabel?.text = Speaker.sharedInstance.getAudioEnabled()
        ? NSLocalizedString("Audio ON. Tap to turn off.", comment: "")
        : NSLocalizedString("Audio OFF. Tap to turn on.", comment: "")
    case .Feedback:
      cell.textLabel?.text = NSLocalizedString("Email Feedback", comment: "")
    case .Logout:
      cell.textLabel?.text = NSLocalizedString("Logout", comment: "")
    }
    
    return cell
  }
}

extension SettingsVC: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    switch SettingsSection(rawValue: indexPath.section)! {
    case .Audio:
      Speaker.sharedInstance.setAudioEnabled(!Speaker.sharedInstance.getAudioEnabled())
      tableView.reloadData()
    case .Feedback:
      self.presentViewController(FeedbackEmailMaker.make(self), animated: true, completion: nil)
    case .Logout:
      showLogoutConfirm()
    }
  }
}

extension SettingsVC: MFMailComposeViewControllerDelegate {
  func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
    dismissViewControllerAnimated(true, completion: nil)
  }
}
