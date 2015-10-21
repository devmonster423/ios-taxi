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

class FlightStatusVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
  var selectedTerminalId: TerminalId!
  var currentHour: Int!
  var flights: [Flight]?
  
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
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .Plain, target: self, action: "goBack")
    navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    navigationController?.navigationBar.translucent = false
    navigationController?.navigationBar.setBackgroundImage(Image.navbarBlue.image(), forBarMetrics: .Default)
    updateFlightTable()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    configureTitle()
  }
  
  func flightStatusView() -> FlightStatusView {
    return view as! FlightStatusView
  }
  
  private func configureTitle() {
    let titleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UiConstants.Dashboard.titleWidth, height: UiConstants.Dashboard.titleHeight))
    titleImageView.image = Image.sfoLogoAlpha.image()
    titleImageView.contentMode = .ScaleAspectFit
    navigationItem.titleView = titleImageView
  }
  
  func goBack() {
    navigationController?.popViewControllerAnimated(true)
  }
  
  func updateFlightTable() {
    let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
    hud.labelText = NSLocalizedString("Requesting Flights...", comment: "")
    
    ApiClient.requestFlightsForTerminal(selectedTerminalId.rawValue, hour: currentHour) { flights, statusCode in

      hud.hide(true)
      
      if let flights = flights where Flight.isValid(flights) {
        self.flights = flights
        self.flightStatusView().flightTable.reloadData()
        
      } else {
        var message = NSLocalizedString("An error occurred while fetching flight data.", comment: "")
        
        if Util.debug {
          if let statusCode = statusCode where statusCode != Util.HttpStatusCodes.Ok.rawValue {
            message += NSLocalizedString("Status code: ", comment: "") + String(statusCode)
          } else {
            message += NSLocalizedString("The flights object was nil.", comment:"")
          }
        }
        
        UiHelpers.displayErrorMessage(self, message: message)
      }
    }
  }
  
  // MARK: UITableView
  
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
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UiConstants.FlightCell.rowHeight
  }
}
