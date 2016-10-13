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

  var errorShown = false
  
  override func loadView() {
    let terminalSummaryView = TerminalSummaryView(frame: UIScreen.main.bounds)
    terminalSummaryView.setReachabilityNoticeHidden(ReachabilityManager.sharedInstance.isReachable())
    terminalSummaryView.setButtonSelectors(
      self,
      decreaseAction: #selector(TerminalSummaryVC.decreaseHour),
      increaseAction: #selector(TerminalSummaryVC.increaseHour)
    )
    terminalSummaryView.setTerminalViewSelector(self, action: #selector(TerminalSummaryVC.terminalSelected(_:)))
    terminalSummaryView.setPickerShowerTarget(self, action: #selector(TerminalSummaryVC.showPicker))
    terminalSummaryView.setPickerDismisserItems([
      UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
      UIBarButtonItem(title: NSLocalizedString("Done", comment: ""),
        style: .done,
        target: self,
        action: #selector(TerminalSummaryVC.hidePicker(_:)))])
    terminalSummaryView.setGrayAreaSelector(self, action: #selector(TerminalSummaryVC.hidePicker(_:)))
    terminalSummaryView.setPickerDataSourceAndDelegate(dataSource:self, delegate: self)
    view = terminalSummaryView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavBar(title: NSLocalizedString("Flight Status", comment: "").uppercased())
    addSettingsButton()

    let nc = NotificationCenter.default
    
    nc.addObserver(
      self,
      selector: #selector(stopTimer),
      name: NSNotification.Name.UIApplicationDidEnterBackground,
      object: nil)
    
    nc.addObserver(
      self,
      selector: #selector(startTimer),
      name: NSNotification.Name.UIApplicationWillEnterForeground,
      object: nil)
    
    nc.addObserver(forName: .reachabilityChanged, object: nil, queue: nil) { note in
      let reachable = note.userInfo![InfoKey.reachable] as! Bool
      self.terminalSummaryView().setReachabilityNoticeHidden(reachable)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    startTimer()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
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
  
  fileprivate func updateTerminalTable() {
    terminalSummaryView().clearTerminalTable()
    terminalSummaryView().resetTimerProgess()
    ApiClient.requestTerminalSummaries(terminalSummaryView().getCurrentHour(), flightType: terminalSummaryView().getCurrentFlightType()) { terminals, hour, statusCode in
      
      if let hour = hour , hour == self.terminalSummaryView().getCurrentHour() {
        if let terminals = terminals {
          self.terminalSummaryView().reloadTerminalViews(terminals)
          
        } else if !self.errorShown {
          
          var message = NSLocalizedString("An error occurred while fetching flight data.", comment: "")
          
          if Util.debug {
            if let statusCode = statusCode , statusCode != Util.HttpStatusCodes.ok.rawValue {
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

  func changeHour(_ delta: Int) {
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
  
  func hidePicker(_ sender: UITapGestureRecognizer) {
    terminalSummaryView().hidePicker()
    terminalSummaryView().updatePickerTitle()
    updateTerminalTable()
  }
  
  func showPicker() {
    terminalSummaryView().showPicker()
  }
  
  func terminalSelected(_ sender: TerminalView) {
    let flightStatusVC = FlightStatusVC()
    flightStatusVC.currentHour = terminalSummaryView().getCurrentHour()
    flightStatusVC.selectedTerminalId = sender.getActiveTerminalId()
    flightStatusVC.flightType = terminalSummaryView().getCurrentFlightType()
    navigationController?.pushViewController(flightStatusVC, animated: true)
  }
}

extension TerminalSummaryVC: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return FlightType.all().count
  }
}

extension TerminalSummaryVC: UIPickerViewDelegate {  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return FlightType.all()[row].asLocalizedString()
  }
}
