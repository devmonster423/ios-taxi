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
import JSQNotificationObserverKit

class TerminalSummaryVC: UIViewController {

  var reachabilityObserver: ReachabilityObserver?
  
  var errorShown = false
  
  override func loadView() {
    let terminalSummaryView = TerminalSummaryView(frame: UIScreen.mainScreen().bounds)
    terminalSummaryView.setReachabilityNoticeHidden(ReachabilityManager.sharedInstance.isReachable())
    terminalSummaryView.setButtonSelectors(
      self,
      decreaseAction: #selector(TerminalSummaryVC.decreaseHour),
      increaseAction: #selector(TerminalSummaryVC.increaseHour)
    )
    terminalSummaryView.setTerminalViewSelector(self, action: #selector(TerminalSummaryVC.terminalSelected(_:)))
    terminalSummaryView.setPickerShowerTarget(self, action: #selector(TerminalSummaryVC.showPicker))
    terminalSummaryView.setPickerDismisserItems([
      UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
      UIBarButtonItem(title: NSLocalizedString("Done", comment: ""),
        style: .Done,
        target: self,
        action: #selector(TerminalSummaryVC.hidePicker(_:)))])
    terminalSummaryView.setGrayAreaSelector(self, action: #selector(TerminalSummaryVC.hidePicker(_:)))
    view = terminalSummaryView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavBar(title: NSLocalizedString("Flight Status", comment: "").uppercaseString)
    addSettingsButton()
    terminalSummaryView().setPickerDataSourceAndDelegate(dataSource:self, delegate: self) // TODO: move to loadView?

    NSNotificationCenter.defaultCenter().addObserver(
      self,
      selector: #selector(stopTimer),
      name: UIApplicationDidEnterBackgroundNotification,
      object: nil)
    
    NSNotificationCenter.defaultCenter().addObserver(
      self,
      selector: #selector(startTimer),
      name: UIApplicationWillEnterForegroundNotification,
      object: nil)
    
    reachabilityObserver = NotificationObserver(notification: SfoNotification.Reachability.reachabilityChanged) { reachable, _ in
      self.terminalSummaryView().setReachabilityNoticeHidden(reachable)
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    startTimer()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    stopTimer()
  }
  
  func terminalSummaryView() -> TerminalSummaryView {
    return view as! TerminalSummaryView
  }
  
  func startTimer() {
    terminalSummaryView().startTimerView(60 * 5, callback: updateTerminalTable)
  }
  
  func stopTimer() {
    terminalSummaryView().stopTimerView()
  }
  
  private func updateTerminalTable() {
    terminalSummaryView().clearTerminalTable()
    terminalSummaryView().resetTimerProgess() // TODO: is this line necessary?
    ApiClient.requestTerminalSummaries(terminalSummaryView().getCurrentHour(), flightType: terminalSummaryView().getCurrentFlightType()) { terminals, hour, statusCode in
      
      if let hour = hour where hour == self.terminalSummaryView().getCurrentHour() {
        if let terminals = terminals {
          self.terminalSummaryView().reloadTerminalViews(terminals)
          
        } else if !self.errorShown {
          
          var message = NSLocalizedString("An error occurred while fetching flight data.", comment: "")
          
          if Util.debug {
            if let statusCode = statusCode where statusCode != Util.HttpStatusCodes.Ok.rawValue {
              message += NSLocalizedString("Status code: ", comment: "") + String(statusCode)
            } else {
              message += NSLocalizedString("The terminals object was nil.", comment:"")
            }
          }
          
          UiHelpers.displayErrorMessage(self, message: message)
          self.errorShown = true
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
