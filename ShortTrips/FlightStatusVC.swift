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
  
  enum TableSection: Int {
    case Header = 0
    case Content = 1
  }
  
  var selectedTerminalId: TerminalId!
  var currentHour: Int!
  var flights: [Flight]?
  
  override func loadView() {
    let flightStatusView = FlightStatusView(frame: UIScreen.mainScreen().bounds)
    flightStatusView.flightTable.dataSource = self
    flightStatusView.flightTable.delegate = self
    flightStatusView.flightTable.registerClass(FlightCell.self, forCellReuseIdentifier: FlightCell.identifier)
    flightStatusView.flightTable.registerClass(FlightHeaderCell.self, forCellReuseIdentifier: FlightHeaderCell.identifier)
    view = flightStatusView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .Plain, target: self, action: "goBack")
    navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(Color.Sfo.blueWithAlpha), forBarMetrics: .Default)
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    updateFlightTable()
    UpdateTimer.start(flightStatusView().timerView, callback: updateFlightTable)
    navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: UiConstants.NavController.font, size: UiConstants.NavController.fontSizeSmall)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
    setupTitle()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    UpdateTimer.stop()
  }
  
  func flightStatusView() -> FlightStatusView {
    return view as! FlightStatusView
  }
  
  func goBack() {
    navigationController?.popViewControllerAnimated(true)
  }
  
  func setupTitle() {
    var title: String = ""
    if currentHour < 0 {
      currentHour = currentHour * -1
      switch selectedTerminalId! {
      case .One:
        title = String(format: NSLocalizedString("Term. One %d Hours Ago", comment: ""), currentHour)
      case .Two:
        title = String(format: NSLocalizedString("Term. Two %d Hours Ago", comment: ""), currentHour)
      case .Three:
        title = String(format: NSLocalizedString("Term. Three %d Hours Ago", comment: ""), currentHour)
      case .International:
        title = String(format: NSLocalizedString("Inter. Term. %d Hours Ago", comment: ""), currentHour)
      }
    }
    else if currentHour > 0 {
      switch selectedTerminalId! {
      case .One:
        title = String(format: NSLocalizedString("Term. One in %d Hours", comment: ""), currentHour)
      case .Two:
        title = String(format: NSLocalizedString("Term. Two in %d Hours", comment: ""), currentHour)
      case .Three:
        title = String(format: NSLocalizedString("Term. Three in %d Hours", comment: ""), currentHour)
      case .International:
        title = String(format: NSLocalizedString("Inter. Term. in %d Hours", comment: ""), currentHour)
      }
    }
    else if currentHour == 0 {
      switch selectedTerminalId! {
      case .One:
        title = NSLocalizedString("Term. One Currently", comment: "")
      case .Two:
        title = NSLocalizedString("Term. Two Currently", comment: "")
      case .Three:
        title = NSLocalizedString("Term. Three Currently", comment: "")
      case .International:
        title = NSLocalizedString("Inter. Term. Currently", comment: "")
      }
    }
    navigationItem.title = title
  }
  
  func updateFlightTable() {
    ApiClient.requestFlightsForTerminal(selectedTerminalId.rawValue, hour: currentHour, response: { (flights, error) -> Void in
        if let flights = flights {
          self.flights = flights
          self.flightStatusView().flightTable.reloadData()
        } else {
          print(error)
        }
    })
  }
  
  func computeDelay() -> Double {
    var totalFlights = 0
    var delayedFlights = 0
    if let flights = flights {
      for flight in flights {
        totalFlights++
        if flight.flightStatus == .Some(.Delayed) {
          delayedFlights++
        }
      }
    }
    
    return Double(delayedFlights) / Double(totalFlights)
  }
  
  // MARK: UITableView
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let flights = flights {
      if section == TableSection.Header.rawValue {
        return 1
      } else {
        return flights.count
      }
    } else {
      return 0
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if indexPath.section == TableSection.Content.rawValue {
      let cell = tableView.dequeueReusableCellWithIdentifier(FlightCell.identifier, forIndexPath: indexPath) as! FlightCell
      if let flights = flights {
        cell.displayFlight(flights[indexPath.row])
      }
      return cell
    } else {
      let cell = tableView.dequeueReusableCellWithIdentifier(FlightHeaderCell.identifier, forIndexPath: indexPath) as! FlightHeaderCell
      cell.displayDelay(computeDelay())
      return cell
    }
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    if indexPath.section == TableSection.Header.rawValue {
      return FlightHeaderCell.height
    } else {
      return FlightCell.height
    }
  }
}
