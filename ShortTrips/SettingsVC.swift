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
    
    configureNavBar(back: true, title: "Settings")
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
    
    switch SettingsSection(rawValue: indexPath.section)! {
    case .Audio:
      cell.textLabel?.text = "Audio"
    case .Faq:
      cell.textLabel?.text = "FAQ"
    case .Logout:
      cell.textLabel?.text = "Logout"
    }
    
    return cell
  }
}

extension SettingsVC: UITableViewDelegate {
  
}
