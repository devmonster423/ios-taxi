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

class TerminalSummaryVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

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
    terminalSummaryView.terminalView1.addGestureRecognizer(UITapGestureRecognizer(target: self,
      action: "terminalSelected:"))
    terminalSummaryView.terminalView2.addGestureRecognizer(UITapGestureRecognizer(target: self,
      action: "terminalSelected:"))
    terminalSummaryView.terminalView3.addGestureRecognizer(UITapGestureRecognizer(target: self,
      action: "terminalSelected:"))
    terminalSummaryView.internationalTerminalView.addGestureRecognizer(UITapGestureRecognizer(target: self,
      action: "terminalSelected:"))
    terminalSummaryView.grayView.addGestureRecognizer(UITapGestureRecognizer(target: self,
      action: "hidePicker:"))
    
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
    ApiClient.requestTerminalSummary(terminalSummaryView().getCurrentHour(), flightType: terminalSummaryView().getCurrentFlightType()) { terminals, hour, statusCode in
      
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
      terminalSummaryView().clearTerminalTable()
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
  
  func hidePicker(sender: UITapGestureRecognizer) {
    terminalSummaryView().hidePicker()
    terminalSummaryView().updatePickerTitle()
    updateTerminalTable()
    terminalSummaryView().timerView.resetProgress()
  }
  
  func showPicker() {
    terminalSummaryView().showPicker()
  }
  
  func terminalSelected(sender: UITapGestureRecognizer) {
    let flightStatusVC = FlightStatusVC()
    flightStatusVC.currentHour = terminalSummaryView().getCurrentHour()
    flightStatusVC.selectedTerminalId = (sender.view as! TerminalView).getActiveTerminalId()
    flightStatusVC.flightType = terminalSummaryView().getCurrentFlightType()
    navigationController?.pushViewController(flightStatusVC, animated: true)
  }
  
  // MARK: UIPickerView
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return FlightType.all().count
  }
  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return FlightType.all()[row].asLocalizedString()
  }
}
