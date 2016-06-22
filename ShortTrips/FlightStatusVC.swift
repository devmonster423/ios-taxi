//
//  FlightStatusVC.swift
//  ShortTrips
//
//  Created by Josh Adams on 7/31/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class FlightStatusVC: UIViewController {
  
  private let minimumSpinnerDuration = NSTimeInterval(2) // seconds
  private var earliestTimeToDismiss: NSDate?
  private var timer: NSTimer?
  private var hud: MBProgressHUD?
  
  var selectedTerminalId: TerminalId!
  var currentHour: Int!
  var flights: [Flight]?
  var flightType: FlightType!
  var errorShown = false
  
  override func loadView() {
    let flightStatusView = FlightStatusView(frame: UIScreen.mainScreen().bounds)
    flightStatusView.flightTable.dataSource = self
    flightStatusView.flightTable.delegate = self
    flightStatusView.flightTable.registerClass(FlightCell.self, forCellReuseIdentifier: FlightCell.identifier)
    view = flightStatusView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavBar(back: true, title: NSLocalizedString("Flight Status", comment: "").uppercaseString)
    addSettingsButton()
    
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
  }
  
  func startTimer() {
    flightStatusView().timerView.start(updateFlightTable, updateInterval: 60 * 5)
  }
  
  func stopTimer() {
    flightStatusView().timerView.stop()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    flightStatusView().tableHeader.text = selectedTerminalId.asLocalizedString() + " " + flightType.asLocalizedString()
    startTimer()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    stopTimer()
  }
  
  func flightStatusView() -> FlightStatusView {
    return view as! FlightStatusView
  }
  
  func attemptToHideSpinner() {
    if earliestTimeToDismiss?.timeIntervalSinceNow < 0 {
      hud?.hide(true)
      timer?.invalidate()
    }
  }
  
  func updateFlightTable() {
    hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
    hud?.labelText = NSLocalizedString("Requesting Flights...", comment: "")
    earliestTimeToDismiss = NSDate().dateByAddingTimeInterval(minimumSpinnerDuration)
    
    ApiClient.requestFlightsForTerminal(selectedTerminalId.rawValue, hour: currentHour, flightType: flightType) { flights, statusCode in

      self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1,
        target: self,
        selector: #selector(FlightStatusVC.attemptToHideSpinner),
        userInfo: nil,
        repeats: true)
      
      if let flights = flights where Flight.isValid(flights) {
        self.flights = flights
        self.flightStatusView().flightTable.reloadData()
        
      } else if !self.errorShown {
        var message = NSLocalizedString("An error occurred while fetching flight data.", comment: "")
        
        if Util.debug {
          if let statusCode = statusCode where statusCode != Util.HttpStatusCodes.Ok.rawValue {
            message += " " + NSLocalizedString("Status code: ", comment: "") + String(statusCode)
          } else {
            message += " " + NSLocalizedString("The flights object was nil.", comment:"")
          }
        }
        
        UiHelpers.displayErrorMessage(self, message: message)
        self.errorShown = true
      }
    }
  }
}

extension FlightStatusVC: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let flights = flights {
      return flights.count
    } else {
      return 0
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(FlightCell.identifier, forIndexPath: indexPath) as! FlightCell
    if let flights = flights {
      cell.displayFlight(flights[indexPath.row], darkBackground: indexPath.row % 2 != 0)
    }
    return cell
  }
}

extension FlightStatusVC: UITableViewDelegate {
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UiConstants.FlightCell.rowHeight
  }
}
