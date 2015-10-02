//
//  FlightStatusVC.swift
//  ShortTrips
//
//  Created by Josh Adams on 7/31/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import UIKit

class FlightStatusVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
  var selectedTerminalId: TerminalId!
  var currentHour: Int!
  var flights: [Flight]?
  
  override func loadView() {
    let flightStatusView = FlightStatusView(frame: UIScreen.mainScreen().bounds)
    flightStatusView.flightTable.dataSource = self
    flightStatusView.flightTable.delegate = self
    flightStatusView.flightTable.registerClass(FlightCell.self, forCellReuseIdentifier: FlightCell.identifier)
    view = flightStatusView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .Plain, target: self, action: "goBack")
    navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    navigationController?.navigationBar.translucent = false
    navigationController?.navigationBar.setBackgroundImage(Image.navbarBlue.image(), forBarMetrics: .Default)
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    updateFlightTable()
    UpdateTimer.start(flightStatusView().timerView, callback: updateFlightTable)
    configureTitle()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    UpdateTimer.stop()
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
    ApiClient.requestFlightsForTerminal(selectedTerminalId.rawValue, hour: currentHour, response: { (flights, error) -> Void in
        if let flights = flights {
          self.flights = flights
        } else {
          print(error)
        }
        self.flightStatusView().flightTable.reloadData()
    })
  }
  
  // MARK: UITableView
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
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
      cell.displayFlight(flights[indexPath.row], darkBackground: indexPath.row % 2 == 0 ? false : true)
    }
    return cell
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UiConstants.FlightCell.rowHeight
  }
}
