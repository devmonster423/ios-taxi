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
  case audio = 0
  case feedback = 1
  case logout = 2
}

class SettingsVC: UIViewController {
  
  let cellId = "cell"
  
  override func loadView() {
    let settingsView = SettingsView(coder: UIScreen.mainScreen.bounds)
    settingsView.tableView.dataSource = self
    settingsView.tableView.delegate = self
    view = settingsView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureNavBar(back: true, title: NSLocalizedString("Settings", comment: "").uppercased())
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let settingsView = view as! SettingsView
    settingsView.tableView.reloadData()
  }
  
  func showUnableToSendMail() {
    let alertController = UIAlertController(title: NSLocalizedString("Unable to send email", comment: ""),
                                            message: "",
                                            preferredStyle: .alert)
    
    let cancelAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
    alertController.addAction(cancelAction)
    
    present(alertController, animated: true, completion: nil)
  }
  
  func showLogoutConfirm() {
    let alertController = UIAlertController(title: NSLocalizedString("Are you sure?", comment: ""),
      message: "",
      preferredStyle: .alert)
    
    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
    alertController.addAction(cancelAction)
    
    let logoutAction = UIAlertAction(title: NSLocalizedString("Logout", comment: ""), style: .default) { (action) in
      self.logout()
    }
    alertController.addAction(logoutAction)
    
    present(alertController, animated: true, completion: nil)
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
    self.present(LoginVC(), animated: true, completion: nil)
    
    Speaker.sharedInstance.setAudioEnabled(originalSetting)
  }
}

extension SettingsVC: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch SettingsSection(rawValue: section)! {
    case .audio:
      return 1
    case .feedback:
      return 1
    case .logout:
      return 1
    }
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch SettingsSection(rawValue: section)! {
    case .logout:
      if let name = DriverManager.sharedInstance.getCurrentDriver()?.fullName() {
        return NSLocalizedString("Logged in as: ", comment: "") + name + ". " + NSLocalizedString("Version: ", comment: "") + Util.versionString()
      } else {
        return nil
      }
    default:
      return nil
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
    cell.selectionStyle = .none
    
    switch SettingsSection(rawValue: (indexPath as NSIndexPath).section)! {
    case .audio:
      cell.textLabel?.text = Speaker.sharedInstance.getAudioEnabled()
        ? NSLocalizedString("Audio ON. Tap to turn off.", comment: "")
        : NSLocalizedString("Audio OFF. Tap to turn on.", comment: "")
    case .feedback:
      cell.textLabel?.text = NSLocalizedString("Email Feedback", comment: "")
    case .logout:
      cell.textLabel?.text = NSLocalizedString("Logout", comment: "")
    }
    
    return cell
  }
}

extension SettingsVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    switch SettingsSection(rawValue: (indexPath as NSIndexPath).section)! {
    case .audio:
      Speaker.sharedInstance.setAudioEnabled(!Speaker.sharedInstance.getAudioEnabled())
      tableView.reloadData()
    case .feedback:
      if let emailMaker = FeedbackEmailMaker.make(self) {
        self.present(emailMaker, animated: true, completion: nil)
      } else {
        showUnableToSendMail()
      }
    case .logout:
      showLogoutConfirm()
    }
  }
}

extension SettingsVC: MFMailComposeViewControllerDelegate {
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    dismiss(animated: true, completion: nil)
  }
}
