//
//  Flight.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/1/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import UIKit

struct Flight {
  let airline: Airline
  let landingTime: NSDate
  let flightStatus: FlightStatus
  let terminal: Terminal
  let flightNumber: Int
  
  init(airline: Airline, landingTime: NSDate, flightStatus: FlightStatus, terminal: Terminal, flightNumber: Int) {
    self.airline = airline
    self.landingTime = landingTime
    self.flightStatus = flightStatus
    self.terminal = terminal
    self.flightNumber = flightNumber
  }
}