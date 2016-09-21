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
import JSQNotificationObserverKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class FlightStatusVC: UIViewController {
  
  fileprivate let minimumSpinnerDuration = TimeInterval(2) // seconds
  fileprivate var earliestTimeToDismiss: Date?
  fileprivate var timer: Timer?
  fileprivate var hud: MBProgressHUD?
  var reachabilityObserver: ReachabilityObserver?
  
  var selectedTerminalId: TerminalId!
  var currentHour: Int!
  var flights: [Flight]?
  var flightType: FlightType!
  var errorShown = false
  
  override func loadView() {
    let flightStatusView = FlightStatusView(frame: UIScreen.main.bounds)
    flightStatusView.setReachabilityNoticeHidden(ReachabilityManager.sharedInstance.isReachable())
    flightStatusView.setupTableView(dataSource: self, delegate: self, cellClasses: [(FlightCell.self, FlightCell.identifier)])
    view = flightStatusView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavBar(back: true, title: NSLocalizedString("Flight Status", comment: "").uppercased())
    addSettingsButton()
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(stopTimer),
      name: NSNotification.Name.UIApplicationDidEnterBackground,
      object: nil)
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(startTimer),
      name: NSNotification.Name.UIApplicationWillEnterForeground,
      object: nil)
    
    reachabilityObserver = NotificationObserver(notification: SfoNotification.Reachability.reachabilityChanged) { reachable, _ in
      self.flightStatusView().setReachabilityNoticeHidden(reachable)
    }
  }
  
  func startTimer() {
    flightStatusView().startTimerView(60 * 5, callback: updateFlightTable)
  }
  
  func stopTimer() {
    flightStatusView().stopTimerView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    flightStatusView().setHeaderText(selectedTerminalId.asLocalizedString() + " " + flightType.asLocalizedString())
    startTimer()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
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
    hud = MBProgressHUD.showAdded(to: view, animated: true)
    hud?.labelText = NSLocalizedString("Requesting Flights...", comment: "")
    earliestTimeToDismiss = Date().addingTimeInterval(minimumSpinnerDuration)
    
    ApiClient.requestFlightsForTerminal(selectedTerminalId.rawValue, hour: currentHour, flightType: flightType) { flights, statusCode in

      self.timer = Timer.scheduledTimer(timeInterval: 0.1,
        target: self,
        selector: #selector(FlightStatusVC.attemptToHideSpinner),
        userInfo: nil,
        repeats: true)
      
      if let flights = flights , Flight.isValid(flights) {
        self.flights = flights
        self.flightStatusView().reloadTableData()
        
      } else if !self.errorShown {
        var message = NSLocalizedString("An error occurred while fetching flight data.", comment: "")
        
        if Util.debug {
          if let statusCode = statusCode , statusCode != Util.HttpStatusCodes.ok.rawValue {
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
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let flights = flights {
      return flights.count
    } else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: FlightCell.identifier, for: indexPath) as! FlightCell
    if let flights = flights {
      cell.displayFlight(flights[(indexPath as NSIndexPath).row], darkBackground: (indexPath as NSIndexPath).row % 2 != 0)
    }
    return cell
  }
}

extension FlightStatusVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UiConstants.FlightCell.rowHeight
  }
}
