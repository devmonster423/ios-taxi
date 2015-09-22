//
//  FlightRequester.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

typealias FlightsForTerminalClosure = ([Flight]?, ErrorType?) -> Void
typealias TerminalSummaryClosure = ([TerminalSummary]?, ErrorType?) -> Void

protocol FlightClient {
  static func requestFlightsForTerminal(terminal: Int, hour: Int, response: FlightsForTerminalClosure)
  static func requestTerminalSummary(hour: Int, response: TerminalSummaryClosure)
}

extension ApiClient {
  static func requestFlightsForTerminal(terminal: Int, hour: Int, response: FlightsForTerminalClosure) {
    let params = ["terminal_id": terminal, "hour": hour]
    authedRequest(Alamofire.request(.GET, Url.Flight.Arrival.details, parameters: params))
      .responseObject { (flightsForTerminalResponse: FlightsForTerminalResponse?, error: ErrorType?) in
      response(flightsForTerminalResponse?.flightDetailResponse?.flightDetails, error)
    }
  }
  
  static func requestTerminalSummary(hour: Int, response: TerminalSummaryClosure) {
    let params = ["hour": hour]
    authedRequest(Alamofire.request(.GET, Url.Flight.Arrival.summary, parameters: params))
      .responseObject { (terminalSummaryResponse: TerminalSummaryResponse?, error: ErrorType?) in response(terminalSummaryResponse?.terminalSummaryArrivalsResponse?.terminalSummaryArrivalsListResponse?.terminalSummaryArrivalsListListResponse?.terminalSummaryArrivalsList, error)
    }
  }
}
