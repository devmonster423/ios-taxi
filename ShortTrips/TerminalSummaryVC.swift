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
    terminalSummaryView.pickerShower.addTarget(self,
      action: "showPicker",
      forControlEvents: .TouchUpInside)
    terminalSummaryView.pickerDismissToolbar.setItems([
      UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
      UIBarButtonItem(title: NSLocalizedString("Done", comment: ""),
        style: .Done,
        target: self,
        action: "hidePicker:")],
      animated: true)
    terminalSummaryView.terminalView1.addTarget(self,
      action: "terminalSelected:",
      forControlEvents: .TouchUpInside)
    terminalSummaryView.terminalView2.addTarget(self,
      action: "terminalSelected:",
      forControlEvents: .TouchUpInside)
    terminalSummaryView.terminalView3.addTarget(self,
      action: "terminalSelected:",
      forControlEvents: .TouchUpInside)
    terminalSummaryView.internationalTerminalView.addTarget(self,
      action: "terminalSelected:",
      forControlEvents: .TouchUpInside)
    terminalSummaryView.grayView.addGestureRecognizer(UITapGestureRecognizer(target: self,
      action: "hidePicker:"))
    
    terminalSummaryView.timerView.start(updateTerminalTable, updateInterval: 60 * 5)
    view = terminalSummaryView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavBar(false)
    updateTerminalTable()
    terminalSummaryView().picker.delegate = self
    terminalSummaryView().picker.dataSource = self
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewDidAppear(animated)
    configureTitle()
  }
  
  func terminalSummaryView() -> TerminalSummaryView {
    return view as! TerminalSummaryView
  }
  
  private func updateTerminalTable() {
    terminalSummaryView().clearTerminalTable()
    terminalSummaryView().timerView.resetProgress()
    ApiClient.requestTerminalSummaries(terminalSummaryView().getCurrentHour(), flightType: terminalSummaryView().getCurrentFlightType()) { terminals, hour, statusCode in
      
      if let hour = hour where hour == self.terminalSummaryView().getCurrentHour() {
        if let terminals = terminals {
          self.terminalSummaryView().reloadTerminalViews(terminals)
          
        } else {
          
          var message = NSLocalizedString("An error occurred while fetching flight data.", comment: "")
          
          if Util.debug {
            if let statusCode = statusCode where statusCode != Util.HttpStatusCodes.Ok.rawValue {
              message += NSLocalizedString("Status code: ", comment: "") + String(statusCode)
            } else {
              message += NSLocalizedString("The terminals object was nil.", comment:"")
            }
          }
          
          UiHelpers.displayErrorMessage(self, message: message)
        }
      }
    }
  }

  func changeHour(delta: Int) {
    let oldCurrentHour = terminalSummaryView().getCurrentHour()
    terminalSummaryView().incrementHour(delta)
    let newCurrentHour = terminalSummaryView().getCurrentHour()
    if oldCurrentHour != newCurrentHour {
      updateTerminalTable()
    }
  }
  
  func decreaseHour() {
    changeHour(-1)
  }
  
  func increaseHour() {
    changeHour(1)
  }
  
  func hidePicker(sender: UITapGestureRecognizer) {
    terminalSummaryView().hidePicker()
    terminalSummaryView().updatePickerTitle()
    updateTerminalTable()
  }
  
  func showPicker() {
    terminalSummaryView().showPicker()
  }
  
  func terminalSelected(sender: TerminalView) {
    let flightStatusVC = FlightStatusVC()
    flightStatusVC.currentHour = terminalSummaryView().getCurrentHour()
    flightStatusVC.selectedTerminalId = sender.getActiveTerminalId()
    flightStatusVC.flightType = terminalSummaryView().getCurrentFlightType()
    navigationController?.pushViewController(flightStatusVC, animated: true)
  }
}

extension TerminalSummaryVC: UIPickerViewDataSource {
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return FlightType.all().count
  }
}

extension TerminalSummaryVC: UIPickerViewDelegate {  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return FlightType.all()[row].asLocalizedString()
  }
}
