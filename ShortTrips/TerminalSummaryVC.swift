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
    terminalSummaryView.terminalView4.addGestureRecognizer(UITapGestureRecognizer(target: self,
      action: "terminalSelected:"))
    view = terminalSummaryView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .Plain, target: self, action: "goBack")
    navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(Color.Sfo.blueWithAlpha), forBarMetrics: .Default)
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
    titleLabel.font = UIFont(name: UiConstants.NavController.font, size: UiConstants.NavController.fontSizeNormal)!
    titleLabel.textColor = UIColor.whiteColor()
    navigationItem.titleView = titleLabel
  }
  
  private func updateTerminalTable() {
    ApiClient.requestTerminalSummary(terminalSummaryView().getCurrentHour(), response: { (terminals, error) -> Void in
      if let terminals = terminals {
        self.terminalSummaryView().reloadTerminalViews(terminals)
      } else {
        let terminals = [
          TerminalSummary(terminalId: TerminalId.International, count: 2, delayedCount: 3),
          TerminalSummary(terminalId: TerminalId.One, count: 3, delayedCount: 2),
          TerminalSummary(terminalId: TerminalId.Two, count: 5, delayedCount: 4),
          TerminalSummary(terminalId: TerminalId.Three, count: 7, delayedCount: 6)
          ]
        self.terminalSummaryView().reloadTerminalViews(terminals)
      }
    })
  }
  
  func decreaseHour() {
    terminalSummaryView().incrementHour(-1)
  }
  
  func increaseHour() {
    terminalSummaryView().incrementHour(1)
  }
  
  func terminalSelected(sender: UITapGestureRecognizer) {
    let flightStatusVC = FlightStatusVC()
    flightStatusVC.currentHour = terminalSummaryView().getCurrentHour()
    flightStatusVC.selectedTerminalId = (sender.view as! TerminalView).activeTerminalId
    navigationController?.pushViewController(flightStatusVC, animated: true)
  }
}
