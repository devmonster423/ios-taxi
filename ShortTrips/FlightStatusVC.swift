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
      if flights != nil {
        self.flights = flights
        println("Successfully retrieved flights.")
      }
      else {
        println("error: \(error)")
        self.createFlights()
        self.flightTable.reloadData()
      }
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

  func createFlights() {
    self.flights = [
      Flight(airline: Airline.DeltaAirlines, landingTime: NSDate(), flightStatus: FlightStatus.Delayed, terminalId: TerminalId.One, flightNumber: 123),
      Flight(airline: Airline.VirginAmerica, landingTime: NSDate(), flightStatus: FlightStatus.Landed, terminalId: TerminalId.Two, flightNumber: 321),
      Flight(airline: Airline.UnitedAirlines, landingTime: NSDate(), flightStatus: FlightStatus.Landed, terminalId: TerminalId.Three, flightNumber: 4242),
      Flight(airline: Airline.AerLingus, landingTime: NSDate(), flightStatus: FlightStatus.OnTime, terminalId: TerminalId.International, flightNumber: 1922),
      Flight(airline: Airline.BritishAirways, landingTime: NSDate(), flightStatus: FlightStatus.OnTime, terminalId: TerminalId.International, flightNumber: 1707),
      Flight(airline: Airline.Lufthansa, landingTime: NSDate(), flightStatus: FlightStatus.Landing, terminalId: TerminalId.International, flightNumber: 1871),
      Flight(airline: Airline.AirFrance, landingTime: NSDate(), flightStatus: FlightStatus.OnTime, terminalId: TerminalId.International, flightNumber: 1958),
      Flight(airline: Airline.DeltaAirlines, landingTime: NSDate(), flightStatus: FlightStatus.Delayed, terminalId: TerminalId.One, flightNumber: 456),
      Flight(airline: Airline.VirginAmerica, landingTime: NSDate(), flightStatus: FlightStatus.OnTime, terminalId: TerminalId.Two, flightNumber: 654),
      Flight(airline: Airline.UnitedAirlines, landingTime: NSDate(), flightStatus: FlightStatus.Landed, terminalId: TerminalId.Three, flightNumber: 333),
      Flight(airline: Airline.DeltaAirlines, landingTime: NSDate(), flightStatus: FlightStatus.Landing, terminalId: TerminalId.One, flightNumber: 666),
      Flight(airline: Airline.UnitedAirlines, landingTime: NSDate(), flightStatus: FlightStatus.Delayed, terminalId: TerminalId.Two, flightNumber: 42),
      Flight(airline: Airline.AerLingus, landingTime: NSDate(), flightStatus: FlightStatus.OnTime, terminalId: TerminalId.International, flightNumber: 111),
      Flight(airline: Airline.AirFrance, landingTime: NSDate(), flightStatus: FlightStatus.Landing, terminalId: TerminalId.International, flightNumber: 777),
      Flight(airline: Airline.Lufthansa, landingTime: NSDate(), flightStatus: FlightStatus.Delayed, terminalId: TerminalId.International, flightNumber: 802)
    ]
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