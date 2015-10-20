//
//  TerminalSummaryVC.swift
//  ShortTrips
//
//  Created by Josh Adams on 8/13/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class TerminalSummaryVC: UIViewController {

  override func loadView() {
    let terminalSummaryView = TerminalSummaryView(frame: UIScreen.mainScreen().bounds)
    terminalSummaryView.decreaseButton.addTarget(self,
      action: "decreaseHour",
      forControlEvents: .TouchUpInside)
    terminalSummaryView.increaseButton.addTarget(self,
      action: "increaseHour",
      forControlEvents: .TouchUpInside)
    terminalSummaryView.terminalView1.addGestureRecognizer(UITapGestureRecognizer(target: self,
      action: "terminalSelected:"))
    terminalSummaryView.terminalView2.addGestureRecognizer(UITapGestureRecognizer(target: self,
      action: "terminalSelected:"))
    terminalSummaryView.terminalView3.addGestureRecognizer(UITapGestureRecognizer(target: self,
      action: "terminalSelected:"))
    terminalSummaryView.internationalTerminalView.addGestureRecognizer(UITapGestureRecognizer(target: self,
      action: "terminalSelected:"))
    terminalSummaryView.timerView.start(updateTerminalTable, updateInterval: 60 * 5)
    view = terminalSummaryView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .Plain, target: self, action: "goBack")
    navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    navigationController?.navigationBar.translucent = false
    navigationController?.navigationBar.setBackgroundImage(Image.navbarBlue.image(), forBarMetrics: .Default)
    updateTerminalTable()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewDidAppear(animated)
    configureTitle()
  }
  
  func terminalSummaryView() -> TerminalSummaryView {
    return view as! TerminalSummaryView
  }
  
  func goBack() {
    navigationController?.popViewControllerAnimated(true)
  }
  
  private func configureTitle() {
    let titleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UiConstants.Dashboard.titleWidth, height: UiConstants.Dashboard.titleHeight))
    titleImageView.image = Image.sfoLogoAlpha.image()
    titleImageView.contentMode = .ScaleAspectFit
    navigationItem.titleView = titleImageView
  }
  
  private func updateTerminalTable() {
    ApiClient.requestTerminalSummary(terminalSummaryView().getCurrentHour(), response: { (terminals, hour, urlResponse, error) -> Void in
      if let urlResponse = urlResponse where urlResponse.statusCode != Util.HttpStatusCodes.Ok.rawValue {
        let message = NSLocalizedString("An error occurred while fetching flight data.", comment: "") + " " + (Util.debug ? NSLocalizedString("Status code: ", comment: "") + String(urlResponse.statusCode) : "")
        UiHelpers.displayMessage(self, title: NSLocalizedString("Error", comment: ""), message: message)
        return
      }
      if let hour = hour, terminals = terminals {
        if hour == self.terminalSummaryView().getCurrentHour() {
          self.terminalSummaryView().reloadTerminalViews(terminals)
        }
      }
      else {
        let message = NSLocalizedString("An error occurred while fetching flight data.", comment: "") + " " + (Util.debug ? NSLocalizedString("The terminals object was nil.", comment:"") : "")
        UiHelpers.displayMessage(self, title: NSLocalizedString("Error", comment: ""), message: message)
      }
    })
  }

  func changeHour(delta: Int) {
    let oldCurrentHour = terminalSummaryView().getCurrentHour()
    terminalSummaryView().incrementHour(delta)
    let newCurrentHour = terminalSummaryView().getCurrentHour()
    if oldCurrentHour != newCurrentHour {
      updateTerminalTable()
      terminalSummaryView().timerView.resetProgress()
    }
  }
  
  func decreaseHour() {
    changeHour(-1)
  }
  
  func increaseHour() {
    changeHour(1)
  }
  
  func terminalSelected(sender: UITapGestureRecognizer) {
    let flightStatusVC = FlightStatusVC()
    flightStatusVC.currentHour = terminalSummaryView().getCurrentHour()
    flightStatusVC.selectedTerminalId = (sender.view as! TerminalView).getActiveTerminalId()
    navigationController?.pushViewController(flightStatusVC, animated: true)
  }
}
