//
//  FlightStatusVC.swift
//  ShortTrips
//
//  Created by Joshua Adams on 7/31/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import UIKit

class FlightStatusVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet var flightTable: UITableView!
  @IBOutlet var delayLabel: UILabel!
  
  var selectedTerminalId: TerminalId?
  var flights: [Flight]?
  var delayRatio: Double?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    flightTable.dataSource = self
    flightTable.delegate = self
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    let terminal: Int
    switch selectedTerminalId! {
    case .One:
      terminal = 1
    case .Two:
      terminal = 2
    case .Three:
      terminal = 3
    case .International:
      terminal = 4
    }
    
    SfoInfoRequester.requestFlights({ (flights, error) -> Void in
      if let flights = flights {
        self.flights = flights
        println("Successfully retrieved flights.")
      }
      else {
        println("error: \(error)")
        self.flights = FlightMock.mockFlights()
      }
      self.flightTable.reloadData()
      self.computeDelay()
      
      self.delayLabel.text = String(format: "%.1f", self.delayRatio! * 100.0)
      self.delayLabel.text = self.delayLabel.text! + NSLocalizedString("% Delayed Flights", comment: "")
      //flightStatusLabel.text = NSLocalizedString(flight.flightStatus!.rawValue, comment: "")

    }, terminal: terminal)
  }
  
  func computeDelay() {
    var totalFlights = 0
    var delayedFlights = 0
    for flight in flights! {
      switch flight.flightStatus! {
      case .Delayed:
        totalFlights++
        delayedFlights++
      case .Landing:
        totalFlights++
      case .OnTime:
        totalFlights++
      default:
        break
      }
    }
    delayRatio = Double(delayedFlights) / Double(totalFlights)
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if flights == nil {
      return 0
    }
    else {
      return flights!.count
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("flightCell", forIndexPath: indexPath) as! FlightCell
    cell.displayFlight(flights![indexPath.row])
    return cell
  }
}