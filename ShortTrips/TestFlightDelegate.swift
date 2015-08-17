//
//  TestFlightDelegate.swift
//  ShortTrips
//
//  Created by Joshua Adams on 7/31/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import UIKit

class TestFlightDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
  let flightTableView: UITableView
  var domesticOrInternational: DomesticOrInternational = .Domestic
  var filteredFlights: [Flight]!
  
  // In the real app, this data will come from the API.
  let flights: [Flight] = [
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
  
  init(flightTableView: UITableView) {
    self.flightTableView = flightTableView
    super.init()
    self.flightTableView.delegate = self
    self.flightTableView.dataSource = self
    filterFlights()
  }
  
  func filterFlights() {
    if domesticOrInternational == DomesticOrInternational.Domestic {
      filteredFlights = flights.filter { $0.terminalId != TerminalId.International }
    }
    else {
      filteredFlights = flights.filter { $0.terminalId == TerminalId.International }
    }
    flightTableView.reloadData()
  }
  
  // MARK: protocol conformance
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredFlights.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("flightCell", forIndexPath: indexPath) as! FlightCell
    cell.displayFlight(filteredFlights[indexPath.row])
    return cell
  }
}
