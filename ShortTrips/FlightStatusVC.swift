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
      
      self.delayLabel.text = String(format: NSLocalizedString("%.1f%% Delayed Flights", comment: ""), self.delayRatio! * 100.0)

    }, terminal: terminal)
  }
  
  func computeDelay() {
    var totalFlights = 0
    var delayedFlights = 0
    if let flights = flights {
        for flight in flights {
            switch flight.flightStatus {
            case .Some(.Delayed):
                totalFlights++
                delayedFlights++
            case .Some(.Landing):
                totalFlights++
            case .Some(.OnTime):
                totalFlights++
            default:
                break
            }
        }
    }
    
    delayRatio = Double(delayedFlights) / Double(totalFlights)
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let flights = flights {
      if section == 0 {
        return 1
      }
      else {
        return flights.count
      }
    }
    else {
      return 0
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("flightCell", forIndexPath: indexPath) as! FlightCell
    if let flights = flights {
      cell.displayFlight(flights[indexPath.row])
    }
    return cell
  }
}