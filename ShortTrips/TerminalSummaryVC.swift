//
//  TerminalSummaryVC.swift
//  ShortTrips
//
//  Created by Josh Adams on 8/13/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import UIKit

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
    view = terminalSummaryView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .Plain, target: self, action: "goBack")
    navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    navigationController?.navigationBar.translucent = false
    navigationController?.navigationBar.setBackgroundImage(Image.navbarBlue.image(), forBarMetrics: .Default)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    configureTitle()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    updateTerminalTable()
    UpdateTimer.start(terminalSummaryView().timerView, callback: updateTerminalTable)
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    UpdateTimer.stop()
  }
  
  func terminalSummaryView() -> TerminalSummaryView {
    return view as! TerminalSummaryView
  }
  
  func goBack() {
    navigationController?.popViewControllerAnimated(true)
  }
  
  private func configureTitle() {
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 240, height: 30))
    titleLabel.text = NSLocalizedString("Terminals", comment: "")
    titleLabel.textAlignment = .Center
    titleLabel.font = UiConstants.NavController.fontNormal
    titleLabel.textColor = UIColor.whiteColor()
    navigationItem.titleView = titleLabel
  }
  
  private func updateTerminalTable() {
    ApiClient.requestTerminalSummary(terminalSummaryView().getCurrentHour(), response: { (terminals, hour, error) -> Void in
      if let hour = hour where hour == self.terminalSummaryView().getCurrentHour(), let terminals = terminals {
        self.terminalSummaryView().reloadTerminalViews(terminals)
      }
    })
  }
  
  func changeHour(delta: Int) {
    let oldCurrentHour = terminalSummaryView().getCurrentHour()
    terminalSummaryView().incrementHour(delta)
    let newCurrentHour = terminalSummaryView().getCurrentHour()
    if oldCurrentHour != newCurrentHour {
      updateTerminalTable()
      UpdateTimer.start(terminalSummaryView().timerView, callback: updateTerminalTable)
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
