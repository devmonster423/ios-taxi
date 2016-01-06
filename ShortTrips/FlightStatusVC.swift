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
  var selectedTerminalId: TerminalId!
  var currentHour: Int!
  var flights: [Flight]?
  var flightType: FlightType!
  
  override func loadView() {
    let flightStatusView = FlightStatusView(frame: UIScreen.mainScreen().bounds)
    flightStatusView.flightTable.dataSource = self
    flightStatusView.flightTable.delegate = self
    flightStatusView.flightTable.registerClass(FlightCell.self, forCellReuseIdentifier: FlightCell.identifier)
    flightStatusView.timerView.start(updateFlightTable, updateInterval: 60 * 5)
    view = flightStatusView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavBar(back: true, title: NSLocalizedString("Flight Status", comment: "").uppercaseString)
    updateFlightTable()
    addLogoutButton()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    flightStatusView().tableHeader.text = selectedTerminalId.asLocalizedString() + " " + flightType.asLocalizedString()
  }
  
  func flightStatusView() -> FlightStatusView {
    return view as! FlightStatusView
  }
  
  func updateFlightTable() {
    let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
    hud.labelText = NSLocalizedString("Requesting Flights...", comment: "")
    
    ApiClient.requestFlightsForTerminal(selectedTerminalId.rawValue, hour: currentHour, flightType: flightType) { flights, statusCode in

      hud.hide(true)
      
      if let flights = flights where Flight.isValid(flights) {
        self.flights = flights
        self.flightStatusView().flightTable.reloadData()
        
      } else {
        var message = NSLocalizedString("An error occurred while fetching flight data.", comment: "")
        
        if Util.debug {
          if let statusCode = statusCode where statusCode != Util.HttpStatusCodes.Ok.rawValue {
            message += " " + NSLocalizedString("Status code: ", comment: "") + String(statusCode)
          } else {
            message += " " + NSLocalizedString("The flights object was nil.", comment:"")
          }
        }
        
        UiHelpers.displayErrorMessage(self, message: message)
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
